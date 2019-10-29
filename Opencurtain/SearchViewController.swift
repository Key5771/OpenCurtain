//
//  SearchViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/27.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var searchTableview: UITableView!
    
    var university: [University] = []
    var faculty: [Faculty] = []
    var department: [Department] = []
    var subscribe: [Subscribe] = []
    
    var cellCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableview.delegate = self
        searchTableview.dataSource = self

        // Do any additional setup after loading the view.
        getSubscribe()
        getUniversity()
        getFaculty()
//        getDepartment()
        
    }

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segment.selectedSegmentIndex == 0 {
            cellCount = subscribe.count
        } else if segment.selectedSegmentIndex == 1 {
            cellCount = faculty.count
            
//            if section == 0 {
//                cellCount = university.count
//            } else if section == 1 {
//                cellCount = faculty.count
//            } else if section == 2 {
//                cellCount = department.count
//            }
//            return 0
        }
        
        return cellCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableview.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        
        if segment.selectedSegmentIndex == 0 {
            cell.label.text = self.subscribe[indexPath.row].board
        } else if segment.selectedSegmentIndex == 1 {
            cell.label.text = faculty[indexPath.row].facultyName
//            if indexPath.section == 0 {
//                cell.label.text = university[indexPath.row].universityName
//            } else if indexPath.section == 1 {
//                cell.label.text = faculty[indexPath.row].facultyName
//            } else if indexPath.section == 2 {
//                cell.label.text = department[indexPath.row].departmentName
//            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTableview.deselectRow(at: indexPath, animated: true)
    }
    
    func getSubscribe() {
        NetworkRequest.shared.requestArray(api: .subscribes, method: .get, type: Subscribe.self) { (response) in
            self.subscribe = response
            self.searchTableview.reloadData()
        }
    }
    
    func getUniversity() {
        NetworkRequest.shared.requestArray(api: .universitys, method: .get, type: University.self) { (response) in
            self.university = response
            self.searchTableview.reloadData()
        }
    }
    
    func getFaculty() {
        NetworkRequest.shared
            .requestArray(url: "/facultys/1", method: .get, type: Faculty.self, completion: { (response) in
                self.faculty = response
                self.searchTableview.reloadData()
            })
    }
    
    func getDepartment() {
        NetworkRequest.shared.requestArray(api: .departments, method: .get, type: Department.self) { (response) in
            self.department = response
            self.searchTableview.reloadData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
