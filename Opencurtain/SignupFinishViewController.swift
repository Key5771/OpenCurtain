//
//  SignupFinishViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/23.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class SignupFinishViewController: UIViewController {
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueButtonClick(_ sender: Any) {
        let vc: UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "loginView")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
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
