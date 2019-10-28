//
//  AddContentViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/25.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class AddContentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var contentTextview: UITextView!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        picker.delegate = self
        
        contentTextview.layer.borderWidth = 1
        contentTextview.layer.borderColor = UIColor.lightGray.cgColor
        contentTextview.layer.cornerRadius = 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func galleryButtonClick(_ sender: Any) {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        contentSetup()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            contentSetup()
        }
    }


    func contentSetup() {
        if contentTextview.text == "" {
            contentTextview.text = "내용 입력"
            contentTextview.textColor = UIColor.lightGray
        } else {
            contentTextview.text = ""
            contentTextview.textColor = UIColor.black
        }
    }
    
    @IBAction func cameraButtonClick(_ sender: Any) {
        if (UIImagePickerController .isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
            picker.modalPresentationStyle = .overFullScreen
            present(picker, animated: false, completion: nil)
        } else {
            print("Camera not available")
        }
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
