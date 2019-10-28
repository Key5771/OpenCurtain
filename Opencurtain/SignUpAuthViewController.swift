//
//  SignUpAuthViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/21.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class SignUpAuthViewController: UIViewController {
    @IBOutlet weak var authCodeTextfield: UITextField!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func postAuth() {
                self.user.authcode = Int(self.authCodeTextfield.text ?? "") ?? 0
        print(user.toJSON())

        NetworkRequest.shared.request(api: .authcheck, method: .post, parameters: user.toJSON()) { (error) in
            if error == nil {
                let viewController = self.storyboard?.instantiateViewController(identifier: "signUpLogin") as? SignUpLoginViewController
                
                viewController?.user = self.user
                self.navigationController?.pushViewController(viewController!, animated: true)
            } else {
                let alertController = UIAlertController(title: "인증번호 오류", message: "인증번호가 틀립니다.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
                print("Get Error : \(error)")
            }
        }
    }
    
    @IBAction func authClick(_ sender: Any) {
        postAuth()
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
