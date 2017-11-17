//
//  LogInViewController.swift
//  SwiftSignDemo
//
//  Created by 高鑫 on 2017/11/16.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, CAAnimationDelegate {
    var demoView = UIView()
    var btn = UIButton()
    var backBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "iBlue")
        btn.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        btn.layer.cornerRadius = 20
        btn.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 100)
        btn.addTarget(self, action: #selector(animateAction(_:)), for: .touchUpInside)
        btn.backgroundColor = UIColor.white
        btn.titleLabel?.font = UIFont(name: "System", size: 17)
        btn.setTitle("执行", for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        self.view.addSubview(btn)
        
        backBtn.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        backBtn.layer.cornerRadius = 20
        backBtn.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 50)
        backBtn.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        backBtn.backgroundColor = UIColor(named: "iBlue2")
        backBtn.titleLabel?.font = UIFont(name: "System", size: 17)
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(UIColor.darkGray, for: .normal)
        self.view.addSubview(backBtn)
        
        demoView.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        demoView.center.x = self.view.center.x
        demoView.center.y = self.view.center.y + 100
        demoView.layer.cornerRadius = demoView.bounds.width / 2
        demoView.backgroundColor = UIColor(named: "iBlue2")
        self.view.addSubview(demoView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func animateAction(_ sender: UIButton) {
        let layer = demoView.layer
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        animation.delegate = self
        animation.duration = 1.5
        let p1 = NSValue(cgRect: CGRect(x: 0, y: 0, width: 60, height: 60))
        let p2 = NSValue(cgRect: CGRect(x: 0, y: 0, width: 20, height: 20))
        let p3 = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1200, height: 1200))
        let r1 = NSValue(cgRect: CGRect(x: 0, y: 0, width: 60, height: 60))
        animation.values = [p1, p2, p3, r1]
        animation.keyTimes = [0.2, 0.3, 0.5, 1]
        animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        let point = CAKeyframeAnimation(keyPath: "position")
        point.delegate = self
        point.duration = 1.5
        let p4 = NSValue(cgPoint: CGPoint(x: layer.position.x, y: layer.position.y))
        let p5 = NSValue(cgPoint: CGPoint(x: layer.position.x, y: layer.position.y - 120))
        let p6 = NSValue(cgPoint: CGPoint(x: layer.position.x, y: layer.position.y - 100))
        let p7 = NSValue(cgPoint: CGPoint(x: layer.position.x, y: layer.position.y - 100))
        let r2 = NSValue(cgPoint: CGPoint(x: layer.position.x, y: layer.position.y))
        point.values = [p4, p5, p6, p7, r2]
        point.keyTimes = [0, 0.2, 0.3, 0.5, 1]
        point.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        
        UIView.animate(withDuration: 0.15, delay: 0.3, options: .curveEaseInOut, animations: {
            self.demoView.layer.cornerRadius = 10
        }) { (_) in
            
        }
        UIView.animate(withDuration: 0.3, delay: 0.45, options: .curveEaseOut, animations: {
            self.demoView.layer.cornerRadius = 600
        }) { (_) in
            
        }
        UIView.animate(withDuration: 0.75, delay: 0.75, options: .curveEaseInOut, animations: {
            self.demoView.layer.cornerRadius = 30
        }, completion: nil)
        
        demoView.layer.add(animation, forKey: "bounds")
        demoView.layer.add(point, forKey: "position")
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        btn.isEnabled = false
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        btn.isEnabled = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
