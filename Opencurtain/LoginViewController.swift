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
    
    var user: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func postLogin() {
        HTTPCookieStorage.shared.cookies?.forEach { HTTPCookieStorage.shared.deleteCookie($0) }
        self.user["email"] = emailTextfield.text ?? ""
        self.user["password"] = passwordTextfield.text ?? ""
        NetworkRequest.shared.request(api: .login, method: .post, parameters: user) { (error) in
            if error == nil {
                self.navigationController?.popViewController(animated: false)
                let viewController = self.storyboard?.instantiateViewController(identifier: "listView")
                viewController?.modalPresentationStyle = .overFullScreen
                self.present(viewController!, animated: true, completion: nil)
            } else {
                print("\(error)")
            }
        }
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
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
