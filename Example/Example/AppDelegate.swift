//Created  on 2019/3/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print_cd("url =>", url.host, url.paths, url.parameters)
        /// 通过 open url 调起
        switch url.host {
        case "host" where url.paths.first != nil:
            /// 在url 协议中 host 代表主工程里的文件
            var param = url.parameters ?? [:]
            param += [Router.PathKey:url.paths.last ?? ""]
            let name = Bundle.main.infoDictionary?.stringValue("CFBundleExecutable") ?? ""
            CD_Router.target(name+"."+url.paths.first!)?.router(param, callback: { (res) in
            })
        case "order" where url.paths.first == "submit":
            let param = url.parameters ?? [:]
            CD_Router.target("Order.VC_Submit")?.router(param, callback: { (res) in
            })
        default:
            var param = url.parameters ?? [:]
            param += [Router.PathKey:url.paths.first ?? ""]
            CD_Router.target(url.host!)?.router(param, callback: { (res) in
            })
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}


extension URL {
    public var paths : [String] {
        var paths = self.pathComponents
        paths.removeAll{ $0 == "/"}
        return paths
    }
    
    public var parameters : [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
        let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
