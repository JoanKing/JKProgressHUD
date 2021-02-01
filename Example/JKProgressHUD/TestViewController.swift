//
//  TestViewController.swift
//  JKProgressHUD
//
//  Created by IronMan on 2021/1/28.
//

import UIKit
import JKProgressHUD
class TestViewController: UIViewController {

    lazy var button: UIView = {
        let btn = UIView(frame: CGRect(x: 30, y: 100, width: 200, height: 200))
        btn.backgroundColor = .yellow
        return btn
    }()
    
    lazy var button2: UIView = {
        let btn = UIView(frame: CGRect(x: 30, y: button.jk.bottom + 20, width: 200, height: 200))
        btn.backgroundColor = .yellow
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .brown
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消刷新", style: .plain, target: self, action: #selector(click))
        self.view.addSubview(button)
        self.view.addSubview(button2)
    }
    
    @objc func click() {
        button2.dismissProgressHUD()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        button.showWait("等待啦")
        button2.showGifInfo("刷新啦...", gifImageName: "loading", gifImagesCount: 22, animationDuration: 2)
        JKAsyncs.asyncDelay(2) {
        } _: {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.button.dismissProgressHUD()
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
