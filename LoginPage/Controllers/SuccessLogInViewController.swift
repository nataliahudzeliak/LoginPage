//
//  SuccessLogInViewController.swift
//  LoginPage
//
//  Created by Family on 7/4/19.
//  Copyright © 2019 Family. All rights reserved.
//

import UIKit

class SuccessLogInViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    
    static var identifier = "SuccessPageViewController"
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    private func setUpView() {
        guard let currentUser = UserInfoManager.sharedInstance().currentUser else { return }
        emailLabel.text = currentUser.email
        firstNameLabel.text = currentUser.firstName
        lastNameLabel.text = currentUser.lastName
        guard let validUrlForImage = URL(string: currentUser.avatar) else { return }
        imageView.load(url: validUrlForImage)
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        UserDefaults.standard.removeObject(forKey: UserDefaults.KeysUser.currentUser)
    }
}
