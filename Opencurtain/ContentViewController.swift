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
    
    var post = Post()
    var comment = Comment()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        } else if section == 1 {
//            return 1
//        }
        return 1
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = contentTableView.dequeueReusableCell(withIdentifier: "contentImage", for: indexPath) as! ContentTableViewCell
        
        cell.titleLabel.text = self.post.title
        
        let time = post.timestamp.components(separatedBy: ["-", "T", ":", "."])
        cell.timeLabel.text = "\(time[0])년 \(time[1])월 \(time[2])일 \(time[3])시 \(time[4])분 \(time[5])초"
        
        cell.nameLabel.text = self.post.user
        
        cell.contentLabel.text = self.post.content
        
        cell.collectionView.isHidden = true
        
        return cell
    }
    
    func postComment() {
        self.comment.posts = self.post.board
        self.comment.comment = ""
        
        NetworkRequest.shared.request(api: .comments, method: .post, parameters: comment.toJSON()) { (error) in
            if error == nil {
                self.contentTableView.reloadData()
            } else {
                print("\(error)")
            }
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
