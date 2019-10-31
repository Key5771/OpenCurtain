//
//  AddContentViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/25.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class AddContentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    @IBOutlet weak var contentTextview: UITextView!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    
    let picker = UIImagePickerController()
    
    var post = Post()
    var boardId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        picker.delegate = self
        
        contentTextview.layer.borderWidth = 1
        contentTextview.layer.borderColor = UIColor.lightGray.cgColor
        contentTextview.layer.cornerRadius = 5
        contentTextview.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        var height = keyboardFrame.height
        if #available(iOS 11.0, *) {
            height -= self.view.safeAreaInsets.bottom
        }
        bottomConstant.constant = height + 8
    }
    
    @objc func keyboardDidHide(notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let height = keyboardFrame.height
        bottomConstant.constant = 8
    }
    
    func postContent() {
        self.post.content = self.contentTextview.text
        self.post.title = self.titleTextfield.text ?? ""
        self.post.board = self.boardId
        
        NetworkRequest.shared.request(api: .posts, method: .post, parameters: post.toJSON()) { (error) in
            if error == nil {
                self.navigationController?.popViewController(animated: true)
            } else {
                print("\(error)")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textViewSetupView()
        }
    }
    
    func textViewSetupView() {
        if contentTextview.text == "내용 입력" {
            contentTextview.text = ""
            contentTextview.textColor = UIColor.black
        } else if contentTextview.text == "" {
            contentTextview.text = "내용 입력"
            contentTextview.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func saveButtonClick(_ sender: Any) {
        postContent()
    }
    
    
    @IBAction func galleryButtonClick(_ sender: Any) {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
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
