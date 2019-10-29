//
//  SideMenuViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/23.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit
import Alamofire

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    var menuArray: [Subscribe] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "totalCell", for: indexPath) as! SideMenuTableViewCell
        
        cell.totalLabel.text = menuArray[indexPath.row].board
        
        return cell
    }
    
    func getSubcribe() {
        NetworkRequest.shared.requestArray(api: .subscribes, method: .get, type: Subscribe.self) { (subscribes) in
            self.menuArray = subscribes
            self.menuTableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getSubcribe()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        self.navigationController?.popViewController(animated: true)
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
