<p>
  <img src="https://github.com/liucaide/Images/blob/master/CaamDau/caamdau.png" align=centre />
</p>

[![CI Status](https://img.shields.io/travis/CaamDau/Router.svg?style=flat)](https://travis-ci.org/CaamDau/Router)
[![Version](https://img.shields.io/cocoapods/v/CaamDauRouter.svg?style=flat)](https://cocoapods.org/pods/CaamDauRouter)
[![License](https://img.shields.io/cocoapods/l/CaamDauRouter.svg?style=flat)](https://cocoapods.org/pods/CaamDauRouter)
[![Platform](https://img.shields.io/cocoapods/p/CaamDauRouter.svg?style=flat)](https://cocoapods.org/pods/CaamDauRouter)
[![](https://img.shields.io/badge/Swift-4.0~5.0-orange.svg?style=flat)](https://cocoapods.org/pods/CaamDauRouter)

# Router
路由组件，极致简约而强大的组件化路由

```
pod 'CaamDauRouter'
或
pod 'CaamDauRouter', :git => 'https://github.com/CaamDau/Router.git'
或
pod 'CaamDau/Router'
```

### 1、配置路由表
- 模块A的开发者自行配置所开发模块A的路由表，遵循 RouterProtocol 协议
- 模块A中需要开放调用的页面，类 遵循 RouterInterface 协议 (类 不需要 public，也就是模块中的所有内容都可私有)
- 模块B 通过路由表调起 模块A
```
public extension Router {}

extension Router {
    // 订单模块
    public enum Order:String, RouterProtocol {
        case list = "list"
        case submit = "submit"

        public var parameter: RouterParameter {
            return [Router.PathKey:self.rawValue]
        }
        public var target: String? {
            switch self {
            case .list:
                return "Order.VC_List"
            case .submit:
                return "Order.VC_Submit"
            }
        }
    }
}
```
### 2、遵循 RouterInterface 协议，提供入口
```

extension VC_Submit: RouterInterface {
    static func router(_ param: RouterParameter = [:], callback: RouterCallback = nil) {
        let vc = VC_Submit.cd_storyboard("OrderStoryboard", from: "Order")!
        vc.vm.id = param.stringValue("id")
        CD.push(vc)
    }
}
class VC_Submit: UIViewController {}
```

### 3、其他模块调起
```
Router.Order.list.router(["idx":1]) { (res) in }
```
### 注意
- 以上已经完成了闭环
- 当然 如果在 路由表 中没有配置 target，
- 那么 需要在 application didFinishLaunchingWithOptions 实现 Router.shared.routerHandler
- 这个时候 建议 将需要开放的页面 另外使用一个 public (struct/class) R_OrderSubmit 遵循 RouterInterface 提供入口
- 不建议将 ViewController public
```
Router.shared.routerHandler = { [weak self](r, param, callback) in
    self?.order(r, param, callback)
}

func order(_ router:RouterProtocol,
    _ param:RouterParameter = [:],
    _ callback:RouterCallback = nil) {
        
    switch router {
    case Router.Order.submit:
        R_OrderSubmit.router(param, callback:callback)
    default: break
    }
        
}

```

**以上就是完整的步骤**
---


**下面的是其他场景中的步骤、两个场景互不干扰**
### 其他场景：OC 或者其他App调起  可通过 open url 
```
#import "CaamDauRouter-Swift.h"

// url模式1： 统一标准的url协议
scheme |   host/模块 |  path/路径
  ↓↓↓         ↓↓↓       ↓↓↓
 caamdau://  order   /submit

[Router openWithUrl:@"caamdau://order/submit" param:@{@"id": @"123456"}];

// url模式2：直接用类名
scheme |    模块   |  类
  ↓↓↓       ↓↓↓      ↓↓↓
 caamdau://Order.VC_Submit

[Router openWithUrl:@"caamdau://Order.VC_Submit" param:@{@"id": @"123456"}];

// 其他App调起
UIApplication.shared.openURL("caamdau://order/submit?id=123456")
```

- 通过 open url 调起 的话需要配置 application open url 进行处理
```
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        /// 通过 open url 调起
        switch url.host {
        case "host" where url.paths.first != nil:
            /// 在url 协议中 host 代表主工程里的文件
            var param = url.parameters ?? [:]
            param += [Router.PathKey:url.paths.last ?? ""]
            let name = Bundle.main.infoDictionary?.stringValue("CFBundleExecutable") ?? ""
            Router.target(name+"."+url.paths.first!)?.router(param, callback: { (res) in
            })
        case "order" where url.paths.first == "submit":
            let param = url.parameters ?? [:]
            Router.target("Order.VC_Submit")?.router(param, callback: { (res) in
            })
        default:
            var param = url.parameters ?? [:]
            param += [Router.PathKey:url.paths.first ?? ""]
            Router.target(url.host!)?.router(param, callback: { (res) in
            })
        }
        return true
    }

```
