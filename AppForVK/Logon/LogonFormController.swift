//
//  LoginFormController.swift
//  AppForVK
//
//  Created by Семериков Михаил on 15.12.2018.
//  Copyright © 2018 Семериков Михаил. All rights reserved.
//

import UIKit

final class LogonFormController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var circle1View: circleView!
    @IBOutlet weak var circle2View: circleView!
    @IBOutlet weak var circle3View: circleView!
    @IBOutlet weak var bezierView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown​), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(​keyboardWillBeHidden​(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        animateCircle()
        
    }
    
    @objc func hideKeyboard() {
        scrollView?.endEditing(true)
    }
    
    @objc func keyboardWasShown​(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func ​keyboardWillBeHidden​(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func logonButton(_ sender: Any) {
        let login = loginTextField.text!
        let password = passwordTextField.text!
        
        if login == "" && password == "" {
            print("Успешная авторизация")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainViewController
            
            present(vc, animated: true)
        } else {
            print("Не верный логин или пароль")
            // Создаем контроллер
            let alter = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
            //Создаем кнопку для UIAlertController
            let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
            // Добавляем кнопку на UIAlertController
            alter.addAction(action)
            // Показываем UIAlertController
            present(alter, animated: true, completion: nil)
        }
    }
    
    func animateCircle() {
        UIView.animate(withDuration: 1, delay: 0.00, options: [.curveEaseOut, .repeat, .autoreverse], animations: {
            self.circle1View.alpha = 0
            }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.33, options: [.curveEaseOut, .repeat, .autoreverse], animations: {
            self.circle2View.alpha = 0
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.67, options: [.curveEaseOut, .repeat, .autoreverse], animations: {
            self.circle3View.alpha = 0
        }, completion: nil)
        
    }
}
