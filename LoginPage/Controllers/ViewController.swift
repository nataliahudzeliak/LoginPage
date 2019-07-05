//
//  ViewController.swift
//  LoginPage
//
//  Created by Family on 7/3/19.
//  Copyright © 2019 Family. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var continueLabel: UILabel!
    @IBOutlet private weak var continueView: UIView!
    @IBOutlet private weak var helpWithLoginLabel: UILabel!
    @IBOutlet private weak var baseOfPhoneLabel: UILabel!
    @IBOutlet private weak var errorViewHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var registrationTextView: UITextView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: UserDefaults.KeysUser.currentUser) != nil {
            loadUserInfo()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: SuccessLogInViewController.identifier) as? SuccessLogInViewController
            navigationController?.pushViewController(controller!, animated: true)
        } else {
            setUpStackView()
            setUpGestures()
            prepareTextView()
            passwordTextField.delegate = self
            phoneNumberTextField.delegate = self
            registrationTextView.delegate = self
            registrationTextView.isSelectable = true
        }
//      let realm = try! Realm()
//         print(realm.objects(UserEntity.self))
//
//        try! realm.write {
//            let user = UserEntity()
//            user.phoneNumber = "+380961235555"
//            user.password = "test"
//            realm.add(user)
//              try! realm.commitWrite()
//        }
//
//        print(realm.objects(UserEntity.self))
//       try! realm.write {
//
//
//        realm.delete(realm.objects(UserEntity.self))
//        }
//        print(realm.objects(UserEntity.self))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        NotificationCenter.default.removeObserver(self)
        phoneNumberTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func loadUserInfo() {
        NetworkManager.sharedInstance().getInfoAboutUser { (user, error) in
            guard let user = user else { return }
            UserInfoManager.sharedInstance().currentUser = user
        }
    }
    
    private func prepareTextView() {
        let youDontHaveAcount = "Do not have an account?"
        let registration = " Sign up"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributedText = NSMutableAttributedString(string: youDontHaveAcount + registration, attributes: [:])
        attributedText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)], range: NSRange(location: 0, length: youDontHaveAcount.count))
        attributedText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold),.paragraphStyle: paragraphStyle], range: NSRange(location: youDontHaveAcount.count, length: registration.count))
        attributedText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.white,.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: youDontHaveAcount.count + registration.count ))

        registrationTextView.attributedText = attributedText
    }

    private func setUpStackView() {
        for view in mainStackView.arrangedSubviews {
            view.layer.cornerRadius = 10
        }
        continueView.layer.borderWidth = 0.2
        continueView.layer.borderColor = #colorLiteral(red: 0.78422755, green: 0.7843633294, blue: 0.784218967, alpha: 1)
        
        baseOfPhoneLabel.addBorder(toSide: [.right], withColor: #colorLiteral(red: 0.78422755, green: 0.7843633294, blue: 0.784218967, alpha: 1), andThickness: 0.3)
    }
    
    private func setUpGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openNextPage))
        helpWithLoginLabel.addGestureRecognizer(tapGesture)
        let tapGestureForegistration = UITapGestureRecognizer(target: self, action: #selector(openNextPage))
        registrationTextView.addGestureRecognizer(tapGestureForegistration)
        let tapLogInGesture = UITapGestureRecognizer(target: self, action: #selector(openSuccessPage))
        continueView.addGestureRecognizer(tapLogInGesture)
    }
    
    private func checkTextField(_ textField: UITextField) -> Bool {
        if textField == passwordTextField, let count = textField.text?.count, count >= 4 {
            return true
        }
        if textField == phoneNumberTextField, let count = textField.text?.count, count == 9 {
            return true
        }
        return false
    }
    
    @objc private func openNextPage(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NextPageViewController")
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func openSuccessPage() {
        let realm = try! Realm()
        let test = "+380\(phoneNumberTextField.text!)"
        let userPhoneNumber = realm.objects(UserEntity.self).filter("phoneNumber == %@", test).first?.phoneNumber
        let userPassword = realm.objects(UserEntity.self).filter("phoneNumber == %@",test).first?.password
        if userPassword == passwordTextField.text, userPhoneNumber == "+380\(phoneNumberTextField.text!)" {
            loadUserInfo()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: SuccessLogInViewController.identifier) as? SuccessLogInViewController
            navigationController?.pushViewController(controller!, animated: true)
        } else {
            errorView.isHidden = false
        }
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        errorView.isHidden = true
        if checkTextField(passwordTextField) && checkTextField(phoneNumberTextField) {
            continueView.backgroundColor = #colorLiteral(red: 0.1943908036, green: 0.5265156627, blue: 0.842076242, alpha: 1)
        } else {
            continueView.backgroundColor = .clear
        }
    }
}

extension ViewController: UITextFieldDelegate , UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case phoneNumberTextField:
            phoneNumberTextField.resignFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
