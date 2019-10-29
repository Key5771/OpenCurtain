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

    override func viewWillAppear(_ animated: Bool) {
        getCurrentUserPost()
        print(post)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myTablevView.delegate = self
        myTablevView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTablevView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyContentTableViewCell
        
        cell.universityLabel.text = post[indexPath.row].title
//        cell.nameLabel.text = post[indexPath.row].user
        cell.nameLabel.text = "현지훈"
        let time = post[indexPath.row].timestamp.components(separatedBy: ["-", "T", ":", "."])
        cell.timeLabel.text = "\(time[0])년 \(time[1])월 \(time[2])일 \(time[3])시 \(time[4])분 \(time[5])초"
        cell.contentLabel.text = post[indexPath.row].content
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCurrentUserPost() {
        NetworkRequest.shared.requestArray(url: "/user/post", method: .get, type: Post.self) { (response) in
            self.post = response
            self.myTablevView.reloadData()
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
