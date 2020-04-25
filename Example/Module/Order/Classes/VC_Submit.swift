//Created  on 2020/4/25 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
extension VC_Submit: CD_RouterInterface {
    static func router(_ param: CD_RouterParameter = [:], callback: CD_RouterCallback = nil) {
        let vc = VC_Submit.cd_storyboard("OrderStoryboard", from: "Order")!
        print_cd("VC_Submit.param：", param)
        CD.push(vc)
    }
}
class VC_Submit: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        
        Router.Sign.up.router() { res in
            print_cd("callback：", res)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
