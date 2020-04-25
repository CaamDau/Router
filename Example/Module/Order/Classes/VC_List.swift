//Created  on 2020/4/25 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
extension VC_List: CD_RouterInterface {
    static func router(_ param: CD_RouterParameter = [:], callback: CD_RouterCallback = nil) {
        let vc = VC_List.cd_storyboard("OrderStoryboard", from: "Order")!
        print_cd("VC_List.param：", param)
        CD.push(vc)
    }
}

class VC_List: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        VC_Submit.router(["id":999])
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
