# JKProgressHUD

[![CI Status](https://img.shields.io/travis/JoanKing/JKProgressHUD.svg?style=flat)](https://travis-ci.org/JoanKing/JKProgressHUD)
[![Version](https://img.shields.io/cocoapods/v/JKProgressHUD.svg?style=flat)](https://cocoapods.org/pods/JKProgressHUD)
[![License](https://img.shields.io/cocoapods/l/JKProgressHUD.svg?style=flat)](https://cocoapods.org/pods/JKProgressHUD)
[![Platform](https://img.shields.io/cocoapods/p/JKProgressHUD.svg?style=flat)](https://cocoapods.org/pods/JKProgressHUD)

## 导入项目的方式
  
    pod 'JKProgressHUD'

## 使用举例，建议如果是控制器使用创建 `UIViewController+Extension.swift` 的扩展，里面的实现如下
   - 1、如果是 gif 帧的图片，图片名字需要是：`xxx_1`、`xxx_2`、`xxx_3` 等格式
   
    extension ViewController {
    
        var jk_isShowGifHUD: Bool {
           return self.view.isShow
        }
      
        func jk_showGifHUD() {
           self.view.showGifInfo("", gifImageName: "loading", gifImagesCount: 22, animationDuration: 2)
        }

        func jk_hideGifHUD() {
           self.view.dismissProgressHUD()
        }
    }
   - 2、JKProgressHUD 如果是正常的其他的提示语提示使用如下
     - 2.1、成功的提示
      
           JKProgressHUD.showSuccess("成功的提示", afterDelay: 1, image: UIImage(named: "图片的名字"))
     - 2.2、失败的提示
     
           JKProgressHUD.showError("失败的提示", afterDelay: 1, image: UIImage(named: "图片的名字"))
     - 2.3、显示普通消息，可添加图片，默认图片名字是：jk_hud_info
          
           JKProgressHUD.showInfo("这是普通提示消息")
     - 2.4、显示等待消息，菊花转圈
        
           JKProgressHUD.showWait("请稍等")
     - 2.5、视图的消失
     
           JKProgressHUD.dismissProgressHUD()
   - 3、UIView扩展的使用如下 ，加入view名字的是：customView，则操作如下
     - 3.1、成功的提示
      
           customView.showSuccess("成功的提示", afterDelay: 1, image: UIImage(named: "图片的名字"))
     - 3.2、失败的提示
     
           customView.showError("失败的提示", afterDelay: 1, image: UIImage(named: "图片的名字"))
     - 3.3、显示普通消息，可添加图片，默认图片名字是：jk_hud_info
          
           customView.showInfo("这是普通提示消息")
     - 3.4、显示等待消息，菊花转圈
        
           customView.showWait("请稍等")
     - 3.5、视图的消失
           
           customView.dismissProgressHUD()

## Author

JoanKing, chongwang27@creditease.cn

## License

JKProgressHUD is available under the MIT license. See the LICENSE file for more info.
