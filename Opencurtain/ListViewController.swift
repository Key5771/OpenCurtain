//
//  ListViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/23.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit
import SideMenu

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sideButton: UIBarButtonItem!
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell
        
        cell.jnuLabel.text = "제주대학교"
        cell.nameLabel.text = "익명"
        cell.timestampLabel.text = "2019년 10월 23일"
        cell.contentLabel.text = "금융권 준비하시는 분 계신가요? 이번에 졸업해서 준비를 하려는데 여러모로 걱정이 많네요 ㅠㅠ ncs 준비는 어떻게 하시는지, 그 외 다른 부분은 어떤거 준…"
        
        return cell
    }
    
    
    
    @IBAction func sideButtonClick(_ sender: Any) {
//        let viewController: SideMenuNavigationController = self.storyboard!.instantiateViewController(withIdentifier: "sideMenuView") as! SideMenuNavigationController
//        viewController.presentationStyle = .viewSlideOutMenuIn
//        self.present(viewController, animated: true, completion: nil)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "board")
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        menu.statusBarEndAlpha = 0
        menu.navigationBar.backgroundColor = UIColor(displayP3Red: 255/255, green: 244/255, blue: 211/255, alpha: 1)
        self.present(menu, animated: true, completion: nil)
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
