//
//  SignUpWebmailViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/21.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class SignUpWebmailViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var webmailTextfield: UITextField!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nextButton.layer.cornerRadius = 5
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        postUserEmail()
    }
    
    func postUserEmail() {
        self.user.email = self.webmailTextfield.text ?? ""
        HTTPCookieStorage.shared.cookies?.forEach { HTTPCookieStorage.shared.deleteCookie($0) }
        NetworkRequest.shared.request(api: .authcode, method: .post, parameters: user.toJSON()) { (error) in
            if error == nil {
                let viewController = self.storyboard?.instantiateViewController(identifier: "auth") as? SignUpAuthViewController
                
                viewController?.user = self.user
                self.navigationController?.pushViewController((viewController)!, animated: true)
            } else {
                let alertController = UIAlertController(title: "이메일 오류", message: "유효하지 않은 이메일입니다.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
                print("Get Error : \(error)")
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
    }
    

}
