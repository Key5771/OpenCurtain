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

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SideMenuViewControllerDelegate {
    
    @IBOutlet weak var sideButton: UIBarButtonItem!
    @IBOutlet weak var listTableView: UITableView!
    
    private let refreshController = UIRefreshControl()
    
    var post: [Post] = []
    var user: [User] = []
    
    var board: (id: Int, name: String) = (1, "전체") {
        didSet {
            self.getPosts()
            self.navigationItem.title = "\(board.name) 글 보기"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPosts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func getPosts() {
        NetworkRequest.shared.requestArray(url: "/posts/\(self.board.id)", method: .get, type: Post.self) { (results) in
            self.post = results
            self.refreshController.endRefreshing()
            self.listTableView.reloadData()
        }
    }
    
    @objc func refresh() {
        getPosts()
        
        
//        // 검색 정렬 필터
//        let word = "제주"
//
//        let newPosts = post.filter { $0.title.contains(word) || $0.content.contains(word) }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell
        
        cell.jnuLabel.text = post[indexPath.row].universityname
        cell.titleLabel.text = post[indexPath.row].title
        cell.nameLabel.text = post[indexPath.row].username
//        cell.nameLabel.text = "현지훈"
        let time = post[indexPath.row].timestamp.components(separatedBy: ["-", "T", ":", "."])
        cell.timestampLabel.text = "\(time[0]). \(time[1]). \(time[2]) \(time[3]): \(time[4])"
        cell.contentLabel.text = post[indexPath.row].content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = self.storyboard?.instantiateViewController(identifier: "contentView") as? ContentViewController
        
        viewController?.post = self.post[indexPath.row]
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    @IBAction func sideButtonClick(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "board")
        if let vc = vc as? SideMenuViewController {
            vc.delegate = self
        }
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.presentationStyle = .menuSlideIn
        menu.leftSide = true
        menu.statusBarEndAlpha = 0
        menu.setNavigationBarHidden(true, animated: false)
        menu.navigationBar.backgroundColor = UIColor(displayP3Red: 255/255, green: 244/255, blue: 211/255, alpha: 1)
        self.present(menu, animated: true, completion: nil)
//        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "writePost" {
            if let viewController = segue.destination as? AddContentViewController {
                viewController.boardId = self.board.id
            }
        }
    }
    

}
