//
//  MyContentViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/29.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class MyContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTablevView: UITableView!
    
    var post: [Post] = []
    var posts: [String:Int] = [:]
    
    private let refreshController = UIRefreshControl()

    override func viewWillAppear(_ animated: Bool) {
        getCurrentUserPost()
        print(post)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myTablevView.delegate = self
        myTablevView.dataSource = self
        
        myTablevView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }
    
    @objc func refresh() {
        getCurrentUserPost()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTablevView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyContentTableViewCell
        
        let count: String = "댓글 수 \(post[indexPath.row].commentcount)"
        
        cell.universityLabel.text = post[indexPath.row].universityname
        cell.titleLabel.text = post[indexPath.row].title
        cell.nameLabel.text = post[indexPath.row].username
//        cell.nameLabel.text = "현지훈"
        let time = post[indexPath.row].timestamp.components(separatedBy: ["-", "T", ":", "."])
        cell.timeLabel.text = "\(time[0]). \(time[1]). \(time[2])    \(time[3]): \(time[4]):"
        cell.contentLabel.text = post[indexPath.row].content
        cell.commentCountLabel.text = count
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "contentView") as? ContentViewController
        
        viewController?.post = self.post[indexPath.row]
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let postId = self.post[indexPath.row].id
            self.posts["posts"] = postId
            print(self.post[indexPath.row].id)
            let deletePost = self.post.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            NetworkRequest.shared.request(url: "/posts/\(deletePost.board)/\(deletePost.id)", method: .delete) { (error) in
                if error == nil {
                    self.myTablevView.reloadData()
                } else {
                    self.post.insert(deletePost, at: indexPath.row)
                    self.myTablevView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    
    func getCurrentUserPost() {
        NetworkRequest.shared.requestArray(url: "/user/post", method: .get, type: Post.self) { (response) in
            self.post = response
            self.myTablevView.reloadData()
            self.refreshController.endRefreshing()
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
