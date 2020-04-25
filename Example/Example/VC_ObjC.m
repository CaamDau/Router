//Created  on 2020/4/25 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




#import "VC_ObjC.h"
#import "蚕豆-Swift.h"
#import "CaamDauRouter-Swift.h"
@interface VC_ObjC ()<CD_RouterInterface>

@end

@implementation VC_ObjC

+ (void)router:(NSDictionary * _Nonnull)param callback:(void (^ _Nullable)(NSDictionary * _Nullable))callback {
    
    VC_ObjC * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"VC_ObjC"];
    UINavigationController * nvc = UIApplication.sharedApplication.keyWindow.rootViewController.childViewControllers.firstObject;
    [nvc pushViewController:vc animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
            [CD_Router openWithUrl:@"caamdaur://order/submit" param:@{@"id": @"123456"}];
            break;
        case 11:
            [CD_Router openWithUrl:@"caamdaur://Order.VC_Submit" param:@{@"id": @"123456"}];
            break;
        case 12:
            [CD_Router openWithUrl:@"caamdaur://host/VC_Web/http" param:@{@"url": @"https://github.com/CaamDau", @"title":@"Web - CaamDau"}];
            break;
        default:
            break;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
