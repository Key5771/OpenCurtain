//
//  SettingViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/28.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutButtonClick(_ sender: Any) {
        let alertController = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "확인", style: .default, handler: {alertAction in
            NetworkRequest.shared.request(api: .logout, method: .get) { (error) in
                if error != nil {
                    print("\(error)")
                } else {
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        })
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelButton)
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
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
