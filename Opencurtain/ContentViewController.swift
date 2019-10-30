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
    @IBOutlet weak var commentButton: UIButton!
    
    
    var post = Post()
    var comments: [Comment] = []
    var comment: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        getComment()
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
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as! ContentTableViewCell
            
            cell.titleLabel.text = self.post.title
            let time = post.timestamp.components(separatedBy: ["-", "T", ":", "."])
            cell.timeLabel.text = "\(time[0]). \(time[1]). \(time[2]). \(time[3]): \(time[4])"
            cell.nameLabel.text = self.post.username
            cell.contentLabel.text = self.post.content
            cell.collectionView?.isHidden = true
            
            return cell
        } else {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! CommentTableViewCell
            cell.nameLabel.text = self.comments[indexPath.row].username
            let time = comments[indexPath.row].timestamp.components(separatedBy: ["-", "T", ":", "."])
            cell.timeLabel.text = "\(time[0]). \(time[1]). \(time[2]). \(time[3]): \(time[4])"
            cell.contentLabel.text = self.comments[indexPath.row].comment
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commentId = self.comments[indexPath.row].id
            let postId = self.post.id
            
            NetworkRequest.shared.request(url: "/comments/\(postId)/\(commentId)", method: .delete) { (error) in
                if error == nil {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            if self.post.user == Storage.shared.user.id || self.comments[indexPath.row].user == Storage.shared.user.id {
                return true
            }
        }
        
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func postComment() {
        comment["comment"] = self.commentTextfield.text ?? ""
        
        NetworkRequest.shared.request(url: "/comments/\(post.id)", method: .post, parameters: comment) { (error) in
            if error == nil {
                self.contentTableView.reloadData()
            } else {
                print("\(error)")
            }
        }
        
    }
    
    func getComment() {
        NetworkRequest.shared.requestArray(url: "/comments/\(post.id)", method: .get, type: Comment.self) { (response) in
            self.comments = response
            self.contentTableView.reloadData()
            print(self.comments.count)
        }
    }
    
    @IBAction func commentButtonClick(_ sender: Any) {
        postComment()
        commentTextfield.text = ""
        commentTextfield.resignFirstResponder()
    }
    
    @IBAction func backgroundClick(_ sender: Any) {
        contentTableView.resignFirstResponder()
        commentTextfield.resignFirstResponder()
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        var height = keyboardFrame.height
        if #available(iOS 11.0, *) {
            height -= self.view.safeAreaInsets.bottom
        }
        contentTableView.setContentOffset(CGPoint(x: 0, y: height/2), animated: true)
        bottomConstant.constant -= (height)
    }
    
    @objc func keyboardDidHide(notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
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
