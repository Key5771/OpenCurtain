//
//  ListViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/23.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import AlamofireObjectMapper

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sideButton: UIBarButtonItem!
    @IBOutlet weak var listTableView: UITableView!
    
    let baseURL = "http://opencurtain.run.goorm.io"
    
    private let refreshController = UIRefreshControl()
    
    var university: [String] = ["제주대학교", "제주한라대학교"]
    var name: [String] = ["익명", "익명"]
    var timestamp: [String] = ["2019년 10월 22일", "2019년 10월 23일"]
    var content: [String] = ["금융권 준비하시는 분 계신가요? 이번에 졸업해서 준비를 하려는데 여러모로 걱정이 많네요 ㅠㅠ ncs 준비는 어떻게 하시는지, 그 외 다른 부분은 어떤거 준…", "얼른 방학했으면 좋겠어요 탈구실 좀......"]
    
    var posts: [Posts] = []
    var post: [Post] = []
    var user: [User] = []
    
    override func viewWillAppear(_ animated: Bool) {
        getPosts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
//        Alamofire.request(baseURL+"/users").responseObject { (response: DataResponse<Users>) in
//            let users = response.result.value
//            if let user = users?.results {
//                for a in user {
//                    print(a.username)
//                }
//                self.user.append(contentsOf: user)
//                self.listTableView.reloadData()
//            }
//        }
        
//        Alamofire.request(baseURL+"/posts").responseObject { (response: DataResponse<Posts>) in
//            let newPosts = response.result.value
//            if let results = newPosts?.results {
//                for a in results {
//                    print(a.title)
//                    print(a.user)
//                    print(a.timestamp)
//                    print(a.content)
//                }
//                self.post.append(contentsOf: results)
//                self.listTableView.reloadData()
//                print("post 배열 : \(self.post)")
//            }
        
        listTableView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func getPosts() {
        NetworkRequest.shared.request(api: .posts, method: .get, type: Posts.self) { (results) in
            self.post = results
            self.refreshController.endRefreshing()
            self.listTableView.reloadData()
        }
    }
    
    @objc func refresh() {
        getPosts()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell
        
        cell.jnuLabel.text = post[indexPath.row].title
//        cell.nameLabel.text = post[indexPath.row].user
        cell.nameLabel.text = "현지훈"
        let time = post[indexPath.row].timestamp.components(separatedBy: ["-", "T", ":", "."])
        cell.timestampLabel.text = "\(time[0])년 \(time[1])월 \(time[2])일 \(time[3])시 \(time[4])분 \(time[5])초"
        cell.contentLabel.text = post[indexPath.row].content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func sideButtonClick(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "board")
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.presentationStyle = .menuSlideIn
        menu.leftSide = true
        menu.statusBarEndAlpha = 0
        menu.navigationBar.backgroundColor = UIColor(displayP3Red: 255/255, green: 244/255, blue: 211/255, alpha: 1)
        self.present(menu, animated: true, completion: nil)
//        self.present(vc, animated: true, completion: nil)
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
