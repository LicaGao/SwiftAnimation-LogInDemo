//
//  ViewController.swift
//  SwiftSignDemo
//
//  Created by 高鑫 on 2017/11/16.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate, UITextFieldDelegate, UIViewControllerTransitioningDelegate {
    var listViewController = ListViewController()
    var signInViewController = SignInViewController()
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var btnsStack: UIStackView!
    @IBAction func logInAction(_ sender: UIButton) {
        logInAction()
    }
    @IBAction func signInAction(_ sender: UIButton) {
        signIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.delegate = self
        passwordTextField.delegate = self
        userView.layer.cornerRadius = 20
        passwordView.layer.cornerRadius = 20
        logInBtn.layer.cornerRadius = 20
        signInBtn.layer.cornerRadius = 20
        userTextField.attributedPlaceholder = NSAttributedString(string: "请输入用户名", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        passwordTextField.isSecureTextEntry = true
        
        let mainView = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        listViewController = mainView.instantiateViewController(withIdentifier: "listView") as! ListViewController
        listViewController.transitioningDelegate = self
        listViewController.modalPresentationStyle = .fullScreen
        signInViewController = mainView.instantiateViewController(withIdentifier: "signIn") as! SignInViewController
        signInViewController.transitioningDelegate = self
        signInViewController.modalPresentationStyle = .fullScreen
        
        userTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.returnKeyType = UIReturnKeyType.done
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logInAction() {
        userTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        let userInfos = UserInfos.userInfos
        if self.userTextField.text != "" && self.passwordTextField.text != "" {
            if userInfos.count != 0 {
                for i in userInfos {
                    if self.userTextField.text == i.user {
                        if self.passwordTextField.text == i.password {
                            logIn()
                        } else {
                            hint(view: self.userView)
                            hint(view: self.passwordView)
                        }
                    } else {
                        hint(view: self.userView)
                        hint(view: self.passwordView)
                    }
                }
            } else {
                hint(view: self.userView)
                hint(view: self.passwordView)
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

    func logIn() {
        self.btnsStack.bringSubview(toFront: self.logInBtn)
        logInBtn.setTitle("", for: .normal)
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        animation.delegate = self
        animation.duration = 1
        let p0 = NSValue(cgRect: logInBtn.bounds)
        let p1 = NSValue(cgRect: CGRect(x: 0, y: 0, width: 40, height: 40))
        let p2 = NSValue(cgRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
        animation.values = [p0, p1, p2]
        animation.keyTimes = [0, 0.3, 1]
        let f0 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let f1 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.timingFunctions = [f0, f1, f0]
        logInBtn.layer.add(animation, forKey: "bounds")
        
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseOut, animations: {
            self.logInBtn.layer.cornerRadius = 560
        }) { (_) in
            self.logInBtn.layer.cornerRadius = 20
            self.logInBtn.setTitle("登录", for: .normal)
            self.present(self.listViewController, animated: true) {
                self.userTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
    }
    
    func signIn() {
        self.btnsStack.bringSubview(toFront: self.signInBtn)
        signInBtn.setTitle("", for: .normal)
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        animation.delegate = self
        animation.duration = 1
        let p0 = NSValue(cgRect: signInBtn.bounds)
        let p1 = NSValue(cgRect: CGRect(x: 0, y: 0, width: 40, height: 40))
        let p2 = NSValue(cgRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
        animation.values = [p0, p1, p2]
        animation.keyTimes = [0, 0.3, 1]
        let f0 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let f1 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.timingFunctions = [f0, f1, f0]
        signInBtn.layer.add(animation, forKey: "bounds")
        
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseOut, animations: {
            self.signInBtn.layer.cornerRadius = 560
        }) { (_) in
            self.signInBtn.layer.cornerRadius = 20
            self.signInBtn.setTitle("注册", for: .normal)
            self.present(self.signInViewController, animated: true, completion: nil)
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Transition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Dismiss()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if userTextField == textField {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.userTextField.textColor = UIColor.darkGray
                self.userView.backgroundColor = UIColor.white
            }, completion: nil)
        }
        if passwordTextField == textField {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.passwordTextField.textColor = UIColor.darkGray
                self.passwordView.backgroundColor = UIColor.white
            }, completion: nil)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if userTextField == textField {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.userView.backgroundColor = UIColor(named: "iBlue")
                self.userTextField.textColor = UIColor.white
            }, completion: nil)
        }
        if passwordTextField == textField {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.passwordView.backgroundColor = UIColor(named: "iBlue")
                self.passwordTextField.textColor = UIColor.white
            }, completion: nil)
        }
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

