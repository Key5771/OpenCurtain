//
//  SignUpLoginViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/21.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class SignUpLoginViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextfield: UITextField!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nextButton.layer.cornerRadius = 5
        
        emailTextField.text = user.email
        
    }
    
    func postIdPw() {
        self.user.password = self.passwordTextField.text ?? ""
        self.user.username = self.usernameTextfield.text ?? ""
    }
    
    @IBAction func nextClick(_ sender: Any) {
        postIdPw()
        let viewController = self.storyboard?.instantiateViewController(identifier: "selectUniversity") as? SelectUniversityViewController
        
        viewController?.user = self.user
        
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
