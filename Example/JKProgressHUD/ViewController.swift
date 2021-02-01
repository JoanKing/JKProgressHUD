//
//  ViewController.swift
//  JKProgressHUD
//
//  Created by JoanKing on 01/29/2021.
//  Copyright (c) 2021 JoanKing. All rights reserved.
//

import UIKit
import MBProgressHUD
class ViewController: BaseViewController {
    /// 可点击的提示框
    var tapHud: MBProgressHUD?
    
    /// 菊花
    lazy var progressHUD: MBProgressHUD = {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .annularDeterminate //显示环形进度条
        hud.progress = 0.0 //当前进度
        hud.label.text = "当前进度：0%"
        return hud
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JKProgressHUD"
        self.view.backgroundColor = UIColor.brown
        self.navigationController?.navigationBar.barTintColor = .brown
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "跳转", style: .plain, target: self, action: #selector(click))
        headDataArray = ["一、使用详解：基本用法，普通提示框", "二、使用详解：带进度的提示框", "三、使用详解：对提示框进行操作：隐藏提示框", "四、使用详解：对提示框进行操作，添加点击手势", "五、修改默认样式", "六、自定义视图", "七、扩展 MBProgressHUD，封装常用方法"]
        dataArray = [["显示最简单的“菊花”的提示", "显示“纯文字”的提示", "显示“纯文字标题 + 详情”的提示", "显示“菊花 + 文字”的提示", "显示“菊花 + 文字标题 + 详情”的提示"], ["使用水平进度条", "使用环形进度条", "使用饼状进度条"], ["隐藏提示框：立刻隐藏", "隐藏提示框：延迟隐藏", "隐藏提示框：通过 minShowTime 属性可以设置最短显示时间（默认为 0）。使用这个设置可以避免提示框显示后立即被隐藏", "隐藏提示框：通过 animationType 属性可以设置提示框消失动画，有如下三种可选值：.fade：逐渐透明消失（默认值）；.zoomOut：逐渐缩小并透明消失；.zoomIn：逐渐放大并透明消失；.zoom：逐渐缩小消失", "隐藏提示框：通过 removeFromSuperViewOnHide 属性，可以设置提示框隐藏的时候是否从父视图中移除（默认为 false）"], ["下面样例给提示框添加个点击手势。当点击提示框后，提示框自动消失。当然在实际应用中，我们还可以在点击响应中进行一些其它操作，比如取消当前的网络请求等等。"], ["设置遮罩的背景色：下面将提示框遮罩设置为黑色半透明（默认为透明的）", "设置毛玻璃效果的遮罩背景：可以看到遮罩下方的控件都会有模糊效果", "设置提示框背景色，下面将提示框的背景色改成透明的", "设置提示框圆角值", "设置文字的颜色和字体", "设置菊花颜色", "设置提示框偏移量，即提示框相对于父视图中心点的偏移，正值为向右下偏移，负值为向左上偏移", "设置提示框内边距", "设置提示框的最小尺寸", "设置正方形提示框"], ["下面样例在提示框中显示一个“❤️”的图标"], ["显示成功消息", "显示失败消息", "显示普通消息，可添加图片", "显示等待消息", "gif动画的刷新"]]
    }
    
    @objc func click() {
        self.navigationController?.pushViewController(TestViewController(), animated: true)
    }
}

// MARK:- 七、扩展 MBProgressHUD，封装常用方法
/**
 这里我们对 MBProgressHUD 类进行扩展（MBProgressHUD+.swift），增加 4 种不同类型提示的显示方法。注意：
 当成功、失败的提示显示后，经过 1 秒钟会自动隐藏消失。
 而普通消息提示和等待提示显示后不会自动取消，需要手动将其隐藏。
 */
extension ViewController {

    // MARK: 7.5、gif动画的刷新
    @objc func test75() {
        //显示等待消息
        JKProgressHUD.showGifInfo("刷新中...", gifImageName: "loading", gifImagesCount: 22, animationDuration: 2)
        JKAsyncs.asyncDelay(2) {
            
        } _: {
            JKProgressHUD.dismissProgressHUD()
        }
    }
    
    // MARK: 7.4、显示等待消息
    @objc func test74() {
        //显示等待消息
        JKProgressHUD.showWait("请稍等")
        JKAsyncs.asyncDelay(2) {
            
        } _: {
            JKProgressHUD.dismissProgressHUD()
        }

    }
    
    // MARK: 7.3、显示普通消息，可添加图片
    @objc func test73() {
        //显示普通消息
        JKProgressHUD.showInfo("这是普通提示消息")
        JKAsyncs.asyncDelay(2) {
            
        } _: {
            JKProgressHUD.dismissProgressHUD()
        }
    }
    
    // MARK: 7.2、显示失败消息
    @objc func test72() {
        //显示失败消息
        JKProgressHUD.showError("操作失败")
    }
    
    // MARK: 7.1、显示成功消息
    @objc func test71() {
        //显示成功消息
        JKProgressHUD.showSuccess("操作成功")
    }
}

// MARK:- 六、自定义视图
// 如果觉得 MBProgressHUD 自带的几种视图样式不能满足需求，我们还可以使用自定义视图
extension ViewController {
    
    // MARK: 6.1、下面样例在提示框中显示一个“❤️”的图标
    @objc func test61() {
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "heart")!) //自定义视图显示图片
        hud.label.text = "操作成功"
        
        hud.hide(animated: true, afterDelay: 2)  // 2秒钟后自动隐藏
    }
}

// MARK:- 五、修改默认样式
extension ViewController {
    
    // MARK: 5.10、设置正方形提示框
    @objc func test510() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "请稍等"
        hud.isSquare = true  //正方形提示框
        
        hud.hide(animated: true, afterDelay: 2)  // 2秒钟后自动隐藏
    }
    
    // MARK: 5.9、设置提示框的最小尺寸
    @objc func test59() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "请稍等"
        hud.minSize = CGSize(width: 250, height: 110)  //设置最小尺寸
        
        hud.hide(animated: true, afterDelay: 2)  // 2秒钟后自动隐藏
    }
    
    // MARK: 5.8、设置提示框内边距
    @objc func test58() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "请稍等"
        hud.margin = 0 // 将各个元素与矩形边框的距离设为0
        
        hud.hide(animated: true, afterDelay: 2)  // 2秒钟后自动隐藏
    }
    
    // MARK: 5.7、设置提示框偏移量，即提示框相对于父视图中心点的偏移，正值为向右下偏移，负值为向左上偏移
    @objc func test57() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "请稍等"
        hud.offset = CGPoint(x: -100, y: -150) // 向左偏移100，向上偏移150
        
        hud.hide(animated: true, afterDelay: 2)  // 2秒钟后自动隐藏
    }
    
    // MARK: 5.6、设置菊花颜色
    @objc func test56() {
        
        //将菊花设置成橙色
        // UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = .red
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "请稍等"
        hud.detailsLabel.text = "具体要等多久我也不知道"
        hud.label.textColor = .orange //标题文字颜色
        hud.label.font = UIFont.systemFont(ofSize: 20) //标题文字字体
        hud.detailsLabel.textColor = .blue //详情文字颜色
        hud.bezelView.style = .solidColor
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 11) //详情文字字体
        hud.hide(animated: true, afterDelay: 2)  //2秒钟后自动隐藏
    }
    
    // MARK: 5.5、设置文字的颜色和字体
    @objc func test55() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "请稍等"
        hud.detailsLabel.text = "具体要等多久我也不知道"
        hud.label.textColor = .orange //标题文字颜色
        hud.label.font = UIFont.systemFont(ofSize: 20) //标题文字字体
        hud.detailsLabel.textColor = .blue //详情文字颜色
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 11) //详情文字字体
        
        hud.hide(animated: true, afterDelay: 2)  //2秒钟后自动隐藏
    }
    
    // MARK: 5.4、设置提示框圆角值
    @objc func test54() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "请稍等"
        hud.bezelView.layer.cornerRadius = 10.0 //设置提示框圆角
        
        hud.hide(animated: true, afterDelay: 2)  //2秒钟后自动隐藏
    }
    
    // MARK: 5.3、设置提示框背景色，下面将提示框的背景色改成透明的
    /**
     提示：如果我们想要把四方形的提示框背景色去掉或者改为其他的颜色，我们做如下操作
     hud.bezelView.color = UIColor.clear //将提示框背景改成透明
     hud.bezelView.style = .solidColor
     如果是blur模式，不管背影色设置成什么颜色，都会被加上半透明的效果，所以要先改其style
     */
    @objc func test53() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = UIColor.clear //将提示框背景改成透明
        hud.bezelView.style = .solidColor
        
        hud.hide(animated: true, afterDelay: 2)  //2秒钟后自动隐藏
    }
    
    // MARK: 5.2、设置毛玻璃效果的遮罩背景：可以看到遮罩下方的控件都会有模糊效果
    @objc func test52() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "请稍等"
        hud.backgroundView.style = .blur  //模糊的遮罩背景
        
        hud.hide(animated: true, afterDelay: 2)  //2秒钟后自动隐藏
    }
    
    // MARK: 5.1、设置遮罩的背景色：下面将提示框遮罩设置为黑色半透明（默认为透明的）
    @objc func test51() {
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //设置提示标题
        hud.label.text = "请稍等"
        //设置遮罩为半透明黑色
        hud.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        hud.hide(animated: true, afterDelay: 2)  //2秒钟后自动隐藏
    }
}

// MARK:- 四、使用详解：对提示框进行操作，添加点击手势
extension ViewController {
    // MARK: 4.1、下面样例给提示框添加个点击手势。当点击提示框后，提示框自动消失。当然在实际应用中，我们还可以在点击响应中进行一些其它操作，比如取消当前的网络请求等等。
    @objc func test41() {
        // 初始化HUD窗口，并置于当前的View当中显示
        self.tapHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.tapHud?.label.text = "请稍等"
        // 添加单击手势
        let tapSingle = UITapGestureRecognizer(target:self,
                                               action:#selector(hudTapped))
        self.tapHud?.addGestureRecognizer(tapSingle)
    }
    
    @objc func hudTapped()  {
        self.tapHud?.hide(animated: true)
    }
}

// MARK:- 三、使用详解：对提示框进行操作：隐藏提示框
extension ViewController {
    
    // MARK: 3.5、隐藏提示框：通过 removeFromSuperViewOnHide 属性，可以设置提示框隐藏的时候是否从父视图中移除（默认为 false）
    @objc func test35() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "请稍等"
        hud.removeFromSuperViewOnHide = true //隐藏时从父视图中移除
        hud.hide(animated: true, afterDelay: 2)  //2秒钟后自动隐藏
    }
    
    // MARK: 3.4、隐藏提示框：通过 animationType 属性可以设置提示框消失动画，有如下三种可选值：.fade：逐渐透明消失（默认值）；.zoomOut：逐渐缩小并透明消失；.zoomIn：逐渐放大并透明消失；.zoom：逐渐缩小消失
    @objc func test34() {
        // .fade：逐渐透明消失（默认值）
        // .zoomOut：逐渐缩小并透明消失
        // .zoomIn：逐渐放大并透明消失
        // .zoom：逐渐缩小消失
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        // 设置消失动画
        hud.animationType = .zoomOut
        //HUD窗口显示2秒后自动隐藏
        hud.hide(animated: true, afterDelay: 2)
    }
    
    // MARK: 3.3、隐藏提示框：通过 minShowTime 属性可以设置最短显示时间（默认为 0）。使用这个设置可以避免提示框显示后立即被隐藏
    @objc func test33() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "请稍等"
        hud.minShowTime = 3  //至少要等3秒钟才隐藏
        hud.hide(animated: true) //由于设置了minShowTime，所以还需等3秒钟才隐藏
    }
    
    
    // MARK: 3.2、隐藏提示框：延迟隐藏
    @objc func test32() {
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //HUD窗口显示2秒后自动隐藏
        hud.hide(animated: true, afterDelay: 2)
    }
    
    // MARK: 3.1、隐藏提示框：立刻隐藏
    @objc func test31() {
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //立刻隐藏HUD窗口
        hud.hide(animated: true)
    }
}

// MARK:- 二、使用详解：带进度的提示框
extension ViewController {
    
    // MARK: 2.3、使用饼状进度条
    @objc func test23() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .determinate //显示饼状进度条
        hud.progress = 0.3 //当前进度
        hud.label.text = "当前进度：30%"
        
        JKAsyncs.asyncDelay(1) {
        } _: {
            hud.progress = 0.5 //当前进度
            hud.label.text = "当前进度：50%"
            JKAsyncs.asyncDelay(1) {
            } _: {
                hud.progress = 1.0 //当前进度
                hud.label.text = "当前进度：100%"
                JKAsyncs.asyncDelay(1) {
                } _: {
                    
                    hud.hide(animated: true)
                }
            }
        }
    }
    
    // MARK: 2.2、使用环形进度条
    @objc func test22() {
        
        progressHUD.progress = 0.0 //当前进度
        progressHUD.label.text = "当前进度：0%"
        
        JKAsyncs.asyncDelay(2) {
        } _: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.progressHUD.progress = 0.5 //当前进度
            weakSelf.progressHUD.label.text = "当前进度：50%"
            JKAsyncs.asyncDelay(2) {
            } _: {
                weakSelf.progressHUD.progress = 1.0 //当前进度
                weakSelf.progressHUD.label.text = "当前进度：100%"
                JKAsyncs.asyncDelay(2) {
                } _: {
                    weakSelf.progressHUD.hide(animated: true)
                }
            }
        }
    }
    
    // MARK: 2.1、使用水平进度条
    @objc func test21() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .determinateHorizontalBar //显示水平进度条
        hud.progress = 0.3 //当前进度
        hud.label.text = "当前进度：30%"
        JKAsyncs.asyncDelay(1) {
        } _: {
            hud.progress = 0.5 //当前进度
            hud.label.text = "当前进度：50%"
            JKAsyncs.asyncDelay(1) {
            } _: {
                hud.progress = 1.0 //当前进度
                hud.label.text = "当前进度：100%"
                JKAsyncs.asyncDelay(1) {
                } _: {
                    hud.hide(animated: true)
                }
            }
        }
    }
}

// MARK:- 一、使用详解：基本用法，普通提示框
extension ViewController {
    
    // MARK: 1.5、显示“菊花 + 文字标题 + 详情”的提示
    @objc func test15() {
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //设置提示标题
        hud.label.text = "请稍等"
        //设置提示详情
        hud.detailsLabel.text = "具体要等多久我也不知道"
        JKAsyncs.asyncDelay(3) {
        } _: {
           hud.hide(animated: true)
        }
    }
    
    // MARK: 1.4、显示“菊花 + 文字”的提示
    @objc func test14() {
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //设置提示文字
        hud.label.text = "请稍等"
        
        JKAsyncs.asyncDelay(3) {
        } _: {
           hud.hide(animated: true)
        }
    }
    
    // MARK: 1.3、显示“纯文字标题 + 详情”的提示
    @objc func test13() {
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //纯文本模式
        hud.mode = .text
        //设置提示标题
        hud.label.text = "请稍等"
        //设置提示详情
        hud.detailsLabel.text = "具体要等多久我也不知道"
        
        // hud.hide(animated: true, afterDelay: 3)
        
        JKAsyncs.asyncDelay(1) {
        } _: {
           hud.hide(animated: true)
        }
    }
    
    // MARK: 1.2、显示“纯文字”的提示
    @objc func test12() {
        //初始化HUD窗口，并置于当前的View当中显示
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //纯文本模式
        hud.mode = .text
        //设置提示文字
        hud.label.text = "请稍等"
        JKAsyncs.asyncDelay(1) {
        } _: {
            hud.hide(animated: true)
        }
    }
    
    // MARK: 1.1、显示最简单的“菊花”的提示
    @objc func test11() {
        //初始化HUD窗口，并置于当前的View当中显示
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        /**
         indeterminate：菊花
         annularDeterminate 进度
         customView 自定义
         determinateHorizontalBar：水平进度
         */
        JKAsyncs.asyncDelay(2) {
        } _: {
            progressHUD.hide(animated: true)
        }

    }
}


