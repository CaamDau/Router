//Created  on 2019/8/2 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDauRouter


public struct Router {
    /// 同一页面 不同模式、状态、类型，进行区分
    public static let PathKey = "router_path"
    static var appName:String {
        return Bundle.main.infoDictionary!["CFBundleExecutable"] as? String ?? ""
    }
}


//MARK:--- 登录注册 ----------
extension Router {
    public enum Sign:String, CD_RouterProtocol {
        case up = "up"
        case out = "out"
        
        public var parameter: CD_RouterParameter {
            return [Router.PathKey:self.rawValue]
        }
        
        public var target: String? {
            return "Sign.VC_Sign"
        }
    }
}

//MARK:--- 订单 ----------
extension Router {
    public enum Order:String, CD_RouterProtocol {
        case list = "list"
        case submit = "submit"
        
        public var parameter: CD_RouterParameter {
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



//MARK:--- 通用 ----------
extension Router {
    public enum Utility:String, CD_RouterProtocol {
        case html = "html"
        case http = "http"
        case file = "file"
        case oc = "oc"
        
        public var parameter: CD_RouterParameter {
            return [Router.PathKey:self.rawValue]
        }
        public var target: String? {
            switch self {
            case .html, .http, .file:
                return appName+".VC_Web"
            default:
                return "VC_ObjC"
            }
            
        }
        
        
    }
}

