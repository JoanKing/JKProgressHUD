//
//  MBProgressHUD+UIView.swift
//  JKProgressHUD
//
//  Created by IronMan on 2021/1/28.
//

import Foundation
import MBProgressHUD
public extension UIView {
    static var JKMBProgressHUD_key = "JKMBProgressHUD_key"
    /// 是否正在展示提示框
    var isShow: Bool {
        guard progressHUD != nil else {
            return false
        }
        return true
    }
    /// 刷新对象
    var progressHUD: MBProgressHUD? {
        get {
            return objc_getAssociatedObject(self, &(UIView.JKMBProgressHUD_key)) as? MBProgressHUD
        }
        set {
            objc_setAssociatedObject(self, &(UIView.JKMBProgressHUD_key), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // MARK: 显示等待消息（菊花）
    /// 显示等待消息
    /// - Parameter title: 消息提示语
    func showWait(_ title: String) {
        // 防止添加多次
        guard progressHUD == nil else {
            return
        }
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        
        progressHUD = hud
    }

    // MARK: 显示普通消息，可添加图片
    /// 显示普通消息
    /// - Parameters:
    ///   - title: 消息提示语
    ///   - image: 提示图片
    func showInfo(_ title: String, image: UIImage? = UIImage(named: "jk_hud_info")) {
        // 防止添加多次
        guard progressHUD == nil else {
            return
        }
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        // 模式设置为自定义视图
        hud.mode = .customView
        // 自定义视图显示图片
        if let showImage = image {
            hud.customView = UIImageView(image: showImage)
        }
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        
        progressHUD = hud
    }
    
    // MARK: 隐藏正在显示的视图
    /// 隐藏正在显示的视图
    func dismissProgressHUD() {
        // 1、不存在就进行移除
        guard let hud = progressHUD else {
            return
        }
        // 2、存在进行移除和置空
        hud.hide(animated: true)
        progressHUD = nil
    }
}

// MARK:- gif图片的刷新
public extension UIView {
    // MARK: 显示Gif刷新消息
    /// 显示Gif刷新消息
    /// - Parameters:
    ///   - title: 普通消息内容
    ///   - gifImageName: 图片的名字，比如图片名字是：loading，gifImagesCount 是6，那么图片6张是：loading_1、loading_2、loading_3、loading_4、loading_5、loading_6
    ///   - gifImagesCount: 图片的数量
    func showGifInfo(_ title: String, gifImageName: String, gifImagesCount: Int, animationDuration: TimeInterval) {
        // 防止添加多次
        guard progressHUD == nil else {
            return
        }
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        // 模式设置为自定义视图
        hud.mode = .customView
        hud.customView = JKProgressHUD.gifCustomView(gifImageName: gifImageName, gifImagesCount: gifImagesCount, animationDuration: animationDuration)
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        
        progressHUD = hud
    }
}

// MARK:- 成功和失败的消息（可以设置消失的时间）
public extension UIView {
    // MARK: 显示成功消息
    /// 显示成功消息
    /// - Parameters:
    ///   - title: 提示语
    ///   - afterDelay: 几秒后消失
    ///   - image: 提示框图片
    func showSuccess(_ title: String, afterDelay: TimeInterval = 1, image: UIImage? = UIImage(named: "jk_hud_success")) {
        successOrError(title, afterDelay: afterDelay, image: image)
    }
 
    // MARK: 显示失败消息
    /// 显示失败消息
    /// - Parameters:
    ///   - title: 提示语
    ///   - afterDelay: 几秒后消失
    ///   - image: 提示框图片
    func showError(_ title: String, afterDelay: TimeInterval = 1, image: UIImage? = UIImage(named: "jk_hud_error")) {
        successOrError(title, afterDelay: afterDelay, image: image)
    }
    
    private func successOrError(_ title: String, afterDelay: TimeInterval = 1, image: UIImage?) {
       
        // 防止添加多次
        guard progressHUD == nil else {
            return
        }
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        // 模式设置为自定义视图
        hud.mode = .customView
        // 自定义视图显示图片
        if let showImage = image {
            hud.customView = UIImageView(image: showImage)
        }
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        // HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 1)
    }
}
