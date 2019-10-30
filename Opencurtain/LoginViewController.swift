//
//  LoginViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/22.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var user: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func postLogin() {
        HTTPCookieStorage.shared.cookies?.forEach { HTTPCookieStorage.shared.deleteCookie($0) }
        self.user["email"] = emailTextfield.text ?? ""
        self.user["password"] = passwordTextfield.text ?? ""
        
        NetworkRequest.shared.request(api: .login, method: .post, type: User.self, parameters: self.user) { (response) in
            if response == nil {
                self.activityIndicator.stopAnimating()
                self.navigationController?.popViewController(animated: false)
                let viewController = self.storyboard?.instantiateViewController(identifier: "listView")
                viewController?.modalPresentationStyle = .overFullScreen
                self.present(viewController!, animated: true, completion: nil)
                Storage.shared.user = response!
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        activityIndicator.startAnimating()
        postLogin()
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
