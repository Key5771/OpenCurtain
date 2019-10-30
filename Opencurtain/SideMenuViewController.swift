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
    
//    var menuArray: [Subscribe] = []
    
    weak var delegate: SideMenuViewControllerDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.shared.subscribes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "totalCell", for: indexPath) as! SideMenuTableViewCell
        
        cell.totalLabel.text = Storage.shared.subscribes[indexPath.row].boardname
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        Storage.shared.getSubscribe {
            self.menuTableView.reloadData()
        }
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.board = (Storage.shared.subscribes[indexPath.row].board, Storage.shared.subscribes[indexPath.row].boardname)
        self.dismiss(animated: true, completion: nil)
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

protocol SideMenuViewControllerDelegate: class {
    var board: (id: Int, name: String) { get set }
}
