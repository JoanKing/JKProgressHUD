//
//  UIViewController+Extension.swift
//  JKProgressHUD_Example
//
//  Created by IronMan on 2021/2/1.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

// MARK:- 针对JKProgressView的扩展
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
