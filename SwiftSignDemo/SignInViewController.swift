//
//  SignInViewController.swift
//  SwiftSignDemo
//
//  Created by 高鑫 on 2017/11/16.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, CAAnimationDelegate, UITextFieldDelegate {
    
    var doneLabel = UILabel()

    @IBAction func backBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBAction func signInBtnAction(_ sender: UIButton) {
        signIn()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        doneLabel.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        doneLabel.text = "注册成功"
        doneLabel.textAlignment = .center
        doneLabel.textColor = UIColor.white
        doneLabel.center = signInBtn.center
        doneLabel.isHidden = true
        doneLabel.alpha = 0
        doneLabel.font = UIFont(name: "System", size: 12)
        self.view.addSubview(doneLabel)
        
        userView.layer.cornerRadius = 20
        passwordView.layer.cornerRadius = 20
        signInBtn.layer.cornerRadius = 20
        userTextField.delegate = self
        passwordTextField.delegate = self
        userTextField.attributedPlaceholder = NSAttributedString(string: "请输入用户名", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        passwordTextField.isSecureTextEntry = true
        userTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.returnKeyType = UIReturnKeyType.done

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signIn() {
        userTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        if self.userTextField.text != "" && self.passwordTextField.text != "" {
            UserInfos.userInfos.append(UserInfo(user: self.userTextField.text!, password: self.passwordTextField.text!))
            signInBtn.setTitle("", for: .normal)
            doneLabel.isHidden = false
            let animation = CAKeyframeAnimation(keyPath: "bounds")
            animation.delegate = self
            animation.duration = 2
            let p0 = NSValue(cgRect: signInBtn.bounds)
            let p1 = NSValue(cgRect: CGRect(x: 0, y: 0, width: 40, height: 40))
            let p2 = NSValue(cgRect: CGRect(x: 0, y: 0, width: 90, height: 90))
            let p3 = NSValue(cgRect: CGRect(x: 0, y: 0, width: 80, height: 80))
            animation.values = [p0, p1, p2, p3, p3, p0]
            animation.keyTimes = [0, 0.1, 0.25, 0.3, 0.45, 1]
            let f0 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            let f1 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animation.timingFunctions = [f0, f1, f0]
            
            let point = CAKeyframeAnimation(keyPath: "position")
            point.delegate = self
            point.duration = 2
            let p4 = NSValue(cgPoint: signInBtn.layer.position)
            let p5 = NSValue(cgPoint: CGPoint(x: signInBtn.layer.position.x, y: signInBtn.layer.position.y + 20))
            point.values = [p4, p5, p5, p4]
            point.keyTimes = [0, 0.1, 0.45, 1]
            point.timingFunctions = [f0, f1, f0]
            signInBtn.layer.add(animation, forKey: "bounds")
            signInBtn.layer.add(point, forKey: "position")
            
            self.doneLabel.frame = self.doneLabel.frame.offsetBy(dx: 0, dy: 20)
            UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseOut, animations: {
                self.signInBtn.layer.cornerRadius = 45
                self.signInBtn.backgroundColor = UIColor(named: "iGreen")
                self.signInBtn.setTitleColor(UIColor.white, for: .normal)
            }) { (_) in
                
            }
            UIView.animate(withDuration: 0.1, delay: 0.5, options: .curveEaseInOut, animations: {
                self.doneLabel.alpha = 1
                self.signInBtn.layer.cornerRadius = 40
            }) { (_) in
                self.dismiss(animated: true, completion: {
                    self.userTextField.text = nil
                    self.passwordTextField.text = nil
                })
            }
        } else {
            if self.userTextField.text == "" {
                hint(view: self.userView)
            }
            if self.passwordTextField.text == "" {
                hint(view: self.passwordView)
            }
        }

    }
    
    func hint(view: UIView) {
        let point = CAKeyframeAnimation(keyPath: "position")
        point.delegate = self
        point.duration = 0.5
        let p4 = NSValue(cgPoint: view.layer.position)
        let p5 = NSValue(cgPoint: CGPoint(x: view.layer.position.x - 5, y: view.layer.position.y))
        let p6 = NSValue(cgPoint: CGPoint(x: view.layer.position.x + 5, y: view.layer.position.y))
        point.values = [p4, p5, p6, p4]
        point.keyTimes = [0, 0.3, 0.6, 1]
        let f1 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        point.timingFunctions = [f1, f1, f1]
        view.layer.add(point, forKey: "position")
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            view.backgroundColor = UIColor(named: "iRed")
        }, completion: nil)
        UIView.animate(withDuration: 0.2, delay: 0.5, options: .curveEaseInOut, animations: {
            view.backgroundColor = UIColor(named: "iBlue")
        }) {(_) in
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func animationDidStart(_ anim: CAAnimation) {
        self.signInBtn.isEnabled = false
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.signInBtn.isEnabled = true
        self.signInBtn.layer.cornerRadius = 20
        self.signInBtn.setTitle("注册", for: .normal)
        self.signInBtn.backgroundColor = UIColor(named: "iBlue2")
        self.signInBtn.setTitleColor(UIColor.darkGray, for: .normal)
        self.doneLabel.alpha = 0
        self.doneLabel.isHidden = true
        self.doneLabel.center = self.signInBtn.center
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if userTextField == textField {
            userTextField.resignFirstResponder()
            return true
        } else {
            passwordTextField.resignFirstResponder()
            return true
        }
    }
}
