//
//  MBProgressHUD+UIView.swift
//  JKProgressHUD
//
//  Created by IronMan on 2021/1/28.
//

import Foundation

public extension UIView {
    static var JKMBProgressHUD_key = "JKMBProgressHUD_key"
    /// 刷新对象
    var progressHUD: JKProgressHUD? {
        get {
            return objc_getAssociatedObject(self, &(UIView.JKMBProgressHUD_key)) as? JKProgressHUD
        }
        set {
            objc_setAssociatedObject(self, &(UIView.JKMBProgressHUD_key), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // MARK: 显示等待消息
    /// 显示等待消息
    /// - Parameter title: 消息提示语
    func showWait(_ title: String) {
        // 防止添加多次
        guard progressHUD == nil else {
            return
        }
        let hud = JKProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        
        progressHUD = hud
    }

    // MARK: 显示普通消息
    /// 显示普通消息
    /// - Parameters:
    ///   - title: 消息提示语
    ///   - image: 提示图片
    func showInfo(_ title: String, image: UIImage? = UIImage(named: "jk_hud_info")) {
        // 防止添加多次
        guard progressHUD == nil else {
            return
        }
        let hud = JKProgressHUD.showAdded(to: self, animated: true)
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

    // MARK: 显示成功消息
    /// 显示成功消息
    /// - Parameters:
    ///   - title: 消息提示语
    ///   - image: 提示图片
    func showSuccess(_ title: String, image: UIImage? = UIImage(named: "jk_hud_success")) {
        // 防止添加多次
        guard progressHUD == nil else {
            return
        }
        let hud = JKProgressHUD.showAdded(to: self, animated: true)
        // 模式设置为自定义视图
        hud.mode = .customView
        // 自定义视图显示图片
        if let showImage = image {
            hud.customView = UIImageView(image: showImage)
        }
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 1)
    }

    // MARK: 显示失败消息
    /// 显示失败消息
    /// - Parameters:
    ///   - title: 消息提示语
    ///   - image: 提示图片
    func showError(_ title: String, image: UIImage? = UIImage(named: "jk_hud_error")) {
        // 防止添加多次
        guard progressHUD == nil else {
            return
        }
        let hud = JKProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        // 自定义视图显示图片
        if let showImage = image {
            hud.customView = UIImageView(image: showImage)
        }
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 1)
    }
    
    // MARK: 隐藏正在显示的视图
    /// 隐藏正在显示的视图
    func dismiss() {
        // 1、不存在就进行移除
        guard let hud = progressHUD else {
            return
        }
        // 2、存在进行移除和置空
        hud.hide(animated: true)
        progressHUD = nil
    }
}
