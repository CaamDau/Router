//Created  on 2020/4/25 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit



extension VC_Sign: CD_RouterInterface {
    static func router(_ param: CD_RouterParameter = [:], callback: CD_RouterCallback = nil) {
        
        let vc = VC_Sign.cd_storyboard("SignStoryboard", from: "Sign") as! VC_Sign
        print_cd("VC_Sign.param：", param)
        vc.callback = callback
        CD.present(vc)
        
        
    }
}


class VC_Sign: UIViewController {

    var callback:CD_RouterCallback
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        switch sender.tag {
        case 10:
            callback?(["msg":"登录成功"])
            CD.dismiss()
        case 11:
            Router.Utility.http.router(["url": "https://github.com/CaamDau", "title":"Web - CaamDau"])
        default:
            break
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
