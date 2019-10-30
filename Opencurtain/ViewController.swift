//
//  ViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/21.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signUpButton.layer.shadowColor = UIColor.black.cgColor
        signUpButton.layer.shadowOpacity = 0.16
        signUpButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        signUpButton.layer.shadowRadius = 5.0
        signUpButton.layer.masksToBounds = false
        signUpButton.layer.cornerRadius = 4.0
        
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOpacity = 0.16
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        loginButton.layer.shadowRadius = 5.0
        loginButton.layer.masksToBounds = false
        loginButton.layer.cornerRadius = 4.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        Storage.shared.checkUser { (error) in
            if error == nil {
                let viewController = self.storyboard?.instantiateViewController(identifier: "listView")
                
                viewController?.modalPresentationStyle = .overFullScreen
                self.present(viewController!, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signUpButtonClick(_ sender: Any) {
        let viewController: UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "signUpView")
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.pushViewController(viewController, animated: true)
//        viewController.modalPresentationStyle = .overFullScreen
//        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        let viewController: UIViewController = self.storyboard!.instantiateViewController(identifier: "loginView")
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.pushViewController(viewController, animated: true)
//        viewController.modalPresentationStyle = .overFullScreen
//        self.present(viewController, animated: true, completion: nil)
    }
    


}

