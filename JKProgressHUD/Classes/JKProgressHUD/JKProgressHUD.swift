//
//  JKProgressHUD.swift
//  JKProgressHUD
//
//  Created by IronMan on 2021/1/29.
//

import Foundation
import MBProgressHUD
/**
 提示：如果我们想要把四方形的提示框背景色去掉或者改为其他的颜色，我们做如下操作
 hud.bezelView.color = UIColor.clear //将提示框背景改成透明
 hud.bezelView.style = .solidColor
 
 如果是blur模式，不管背影色设置成什么颜色，都会被加上半透明的效果，所以要先改其style
 */
public class JKProgressHUD: NSObject {}

public extension JKProgressHUD {
    
    // MARK: 显示等待消息（菊花）
    /// 显示等待消息（菊花）
    /// - Parameter title: 等待的文字
    static func showWait(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
    }

    // MARK: 显示普通消息，可添加图片
    /// 显示普通消息，可添加图片
    /// - Parameters:
    ///   - title: 普通消息内容
    ///   - imageName: 图片的名字（没有图片就不显示名字），建议把图片名字改为：jk_hud_info
    static func showInfo(_ title: String, _ imageName: String = "jk_hud_info") {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        if let showImage = UIImage(named: imageName) {
            hud.customView = UIImageView(image: showImage)
        }
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
    }
     
    // MARK: 隐藏正在显示的视图
    /// 隐藏正在显示的视图
    static func dismissProgressHUD() {
        let view = viewToShow()
        MBProgressHUD.hide(for: view, animated: true)
    }
}

// MARK:- gif图片的刷新
public extension JKProgressHUD {
    // MARK: 显示Gif刷新消息
    /// 显示Gif刷新消息
    /// - Parameter title: 普通消息内容
    static func showGifInfo(_ title: String, gifImageName: String, gifImagesCount: Int, animationDuration: TimeInterval) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = gifCustomView(gifImageName: gifImageName, gifImagesCount: gifImagesCount, animationDuration: animationDuration)
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
    }
}

// MARK:- 成功和失败的消息（可以设置消失的时间）
public extension JKProgressHUD {
    // MARK: 显示成功消息
    /// 显示成功消息
    /// - Parameters:
    ///   - title: 提示语
    ///   - afterDelay: 几秒后消失
    ///   - image: 提示框图片
    static func showSuccess(_ title: String, afterDelay: TimeInterval = 1, image: UIImage? = UIImage(named: "jk_hud_success")) {
        successOrError(title, afterDelay: afterDelay, image: image)
    }
 
    // MARK: 显示失败消息
    /// 显示失败消息
    /// - Parameters:
    ///   - title: 提示语
    ///   - afterDelay: 几秒后消失
    ///   - image: 提示框图片
    static func showError(_ title: String, afterDelay: TimeInterval = 1, image: UIImage? = UIImage(named: "jk_hud_error")) {
        successOrError(title, afterDelay: afterDelay, image: image)
    }
    
    private static func successOrError(_ title: String, afterDelay: TimeInterval = 1, image: UIImage? = UIImage(named: "jk_hud_error")) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        // 自定义视图显示图片
        if let showImage = image {
            hud.customView = UIImageView(image: showImage)
        }
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: afterDelay)
    }
}


// MARK:- fileprivate
extension JKProgressHUD {
    
    // MARK: 获取用于显示提示框的view
    /// 获取用于显示提示框的view
    /// - Returns: 提示框的view
    static func viewToShow() -> UIView {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windowArray = UIApplication.shared.windows
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindow.Level.normal {
                    window = tempWin
                    break
                }
            }
        }
        return window!
    }
    
     static func gifCustomView(gifImageName: String, gifImagesCount: Int, animationDuration: TimeInterval) -> UIView {
        
        guard let image = UIImage(named:"\(gifImageName)_1") else {
            return UIView()
        }
        let mainImageView = UIImageView(image: image)
        mainImageView.layer.allowsGroupOpacity = false
        mainImageView.alpha = 1
        mainImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        mainImageView.animationImages = animationImages(gifImageName: gifImageName, gifImagesCount: gifImagesCount)
        mainImageView.animationDuration = animationDuration
        mainImageView.startAnimating()
        return mainImageView
    }

    private static func animationImages(gifImageName: String, gifImagesCount: Int) -> [UIImage] {
        var imgList = [UIImage]()
        for index in 1...gifImagesCount {
            guard let image = UIImage(named: "\(gifImageName)_\(index)") else {
                return imgList
            }
            imgList.append(image)
        }
        return imgList
    }
}
