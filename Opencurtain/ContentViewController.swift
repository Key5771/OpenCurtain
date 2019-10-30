//
//  ContentViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/28.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var commentTextfield: UITextField!
    
    var post = Post()
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return comments.count
        }
        return 0
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "contentImage", for: indexPath) as! ContentTableViewCell
            
            cell.titleLabel.text = self.post.title
            let time = post.timestamp.components(separatedBy: ["-", "T", ":", "."])
            cell.timeLabel.text = "\(time[0])년 \(time[1])월 \(time[2])일 \(time[3])시 \(time[4])분 \(time[5])초"
            cell.nameLabel.text = self.post.user
            cell.contentLabel.text = self.post.content
            cell.collectionView.isHidden = true
            
            return cell
        } else {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! CommentTableViewCell
            cell.nameLabel.text = self.comments[indexPath.row].user
            let time = comments[indexPath.row].timestamp.components(separatedBy: ["-", "T", ":", "."])
            cell.timeLabel.text = "\(time[0])년 \(time[1])월 \(time[2])일 \(time[3])시 \(time[4])분 \(time[5])초"
            cell.contentLabel.text = self.comments[indexPath.row].comment
            
            return cell
        }
    }
    
    func postComment() {
        var comment: [String:String] = [:]
        comment["comment"] = self.commentTextfield.text ?? ""
//        self.comments.user = self.post.user
//        self.comments.posts = self.post.board
//        self.comments.comment = ""
        
        NetworkRequest.shared.request(api: .comments, method: .post, parameters: comment) { (error) in
            if error == nil {
                self.contentTableView.reloadData()
            } else {
                print("\(error)")
            }
        }
        
    }
    
    @IBAction func backgroundClick(_ sender: Any) {
        contentTableView.resignFirstResponder()
        commentTextfield.resignFirstResponder()
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let height = keyboardFrame.height
        contentTableView.setContentOffset(CGPoint(x: 0, y: height/2), animated: true)
        bottomConstant.constant -= (height - 83)
    }
    
    @objc func keyboardDidHide(notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let height = keyboardFrame.height
        bottomConstant.constant = 0
        contentTableView.scrollIndicatorInsets.bottom += height
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
