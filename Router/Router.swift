//Created  on 2018/7/15  by LCD :https://github.com/liucaide .

/***** 模块文档 *****
 * 提供一个路由协议
*/

import Foundation

public typealias RouterParameter = [AnyHashable:Any]
public typealias RouterCallback = ((RouterParameter?)->Void)?

/// 输入协议：路由表协议
public protocol RouterProtocol {
    /// 目标 如："Home.R_Home" (Home: 模块、组件 命名空间，R_Home：接口类)
    var target:String? {get}
    /// 增补固定参数
    var parameter:RouterParameter {get}
    /// 入参、回参 模糊，自由度更好
    func router(_ param:RouterParameter, callback:RouterCallback)
}
extension RouterProtocol {
    /// 目标 如："Home.R_Home" (Home: 模块、组件 命名空间，R_Home：接口类)
    public var target:String? { return nil }
    public var parameter:RouterParameter { return [:] }
    
    /// 入参、回参 模糊，自由度更好
    public func router(_ param:RouterParameter = [:], callback:RouterCallback = nil) {
        self.routerCore(param, callback: callback)
    }
    
    public func routerCore(_ param:RouterParameter, callback:RouterCallback) {
        if  let target = target, let r = Router.target(target) {
            var param = param
            parameter.forEach{ param[$0.key] = $0.value }
            r.router(param, callback: callback)
        }else{
            var param = param
            parameter.forEach{ param[$0.key] = $0.value }
            Router.shared.routerHandler?(self, param, callback)
        }
    }
}

@objc public class Router: NSObject {
    private override init(){}
    public static let shared = Router()
    public var routerHandler:((_ router:RouterProtocol, _ parameter:RouterParameter, _ callback:RouterCallback)->Void)?
}
extension Router {
    /// 直接通过 URL 配合 application open url 进行寻址
    @objc public class func open(url string:String, param:RouterParameter = [:]) {
        guard let urlComponents = NSURLComponents(string: string) else {
            debugPrint("Router withURL string error:", string)
            return
        }
        var items:[URLQueryItem] = []
        param.forEach {
            guard let key = $0.key as? String, let value = $0.value as? String else { return }
            items.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = items
        
        guard let url = urlComponents.url else {
            debugPrint("Router withURL error:", urlComponents)
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

/// 对外接口路由协议 用于直接页面开放接口路由： ViewController.router([:], callback:{_ in })
public protocol RouterInterface {
    static func router(_ param:RouterParameter, callback:RouterCallback)
}

extension Router {
    public static func target(_ string:String) -> RouterInterface.Type? {
        return NSClassFromString(string) as? RouterInterface.Type
    }
}
