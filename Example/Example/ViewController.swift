//Created  on 2019/3/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */



import Foundation
import UIKit
import CaamDauRouter

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        switch sender.tag {
        case 10:
            Router.Order.list.router(["idx":1]) { (res) in
                
            }
        case 11:
            Router.Utility.oc.router()
        default:
            break
        }
        
    }
}

