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
    
    var user: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nextButton.layer.cornerRadius = 5
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        postUserEmail()
    }
    
    func postUserEmail() {
        NetworkRequest.shared.request(api: .users, method: .post, type: Users.self) { (results) in
            
        }
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
