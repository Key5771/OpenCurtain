//
//  SearchViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/27.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var searchTableview: UITableView!
    
    var university: [University] = []
    var faculty: [Faculty] = []
    var department: [Department] = []
    var addSubscribe: [String:Int] = [:]
    
    var newUniversity: [University] = []
    var newFaculty: [Faculty] = []
    var newDepartment: [Department] = []
    
    var cellCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableview.delegate = self
        searchTableview.dataSource = self
        
        searchBar.delegate = self

        // Do any additional setup after loading the view.
        Storage.shared.getSubscribe { }
        getUniversity()
        getFaculty()
        getDepartment()
        
    }
    
    @IBAction func segmentTap(_ sender: UISegmentedControl) {
        searchTableview.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            search()
        }
        
        self.searchTableview.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.searchBar.endEditing(true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        self.view.endEditing(true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if segment.selectedSegmentIndex == 1 {
            return 3
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segment.selectedSegmentIndex == 0 {
            cellCount = Storage.shared.subscribes.count
        } else if segment.selectedSegmentIndex == 1 {
            if section == 0 {
                if searchBar.text == "" {
                    cellCount = university.count
                } else {
                    cellCount = newUniversity.count
                }
            } else if section == 1 {
                if searchBar.text == "" {
                    cellCount = faculty.count
                } else {
                    cellCount = newFaculty.count
                }
            } else if section == 2 {
                if searchBar.text == "" {
                    cellCount = department.count
                } else {
                    cellCount = newDepartment.count
                }
            }
        }
        
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if segment.selectedSegmentIndex == 1 {
            if section == 0 {
                return "학교"
            } else if section == 1 {
                return "학부"
            } else if section == 2 {
                return "학과"
            }
        }
        return nil
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableview.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        
        if segment.selectedSegmentIndex == 0 {
            cell.label.text = Storage.shared.subscribes[indexPath.row].boardname
            cell.subscribeLabel.isHidden = true
        } else if segment.selectedSegmentIndex == 1 {
            let boards = Storage.shared.subscribes.map { (subscribe) -> Int in
                return subscribe.board
            }
            
            if indexPath.section == 0 {
                if searchBar.text == "" {
                    cell.label.text = university[indexPath.row].boardName
                    if boards.contains(university[indexPath.row].board) {
                        cell.subscribeLabel.isHidden = false
                    } else {
                        cell.subscribeLabel.isHidden = true
                    }
                } else {
                    cell.label.text = newUniversity[indexPath.row].boardName
                    if boards.contains(newUniversity[indexPath.row].board) {
                        cell.subscribeLabel.isHidden = false
                    } else {
                        cell.subscribeLabel.isHidden = true
                    }
                }
                
            } else if indexPath.section == 1 {
                if searchBar.text == "" {
                    cell.label.text = faculty[indexPath.row].boardName
                    if boards.contains(self.faculty[indexPath.row].board) {
                        cell.subscribeLabel.isHidden = false
                    } else {
                        cell.subscribeLabel.isHidden = true
                    }
                } else {
                    cell.label.text = newFaculty[indexPath.row].boardName
                    if boards.contains(self.newFaculty[indexPath.row].board) {
                        cell.subscribeLabel.isHidden = false
                    } else {
                        cell.subscribeLabel.isHidden = true
                    }
                }
                
            } else if indexPath.section == 2 {
                if searchBar.text == "" {
                    cell.label.text = department[indexPath.row].boardName
                    if boards.contains(self.department[indexPath.row].board) {
                        cell.subscribeLabel.isHidden = false
                    } else {
                        cell.subscribeLabel.isHidden = true
                    }
                } else {
                    cell.label.text = newDepartment[indexPath.row].boardName
                    if boards.contains(self.newDepartment[indexPath.row].board) {
                        cell.subscribeLabel.isHidden = false
                    } else {
                        cell.subscribeLabel.isHidden = true
                    }
                }
                
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTableview.deselectRow(at: indexPath, animated: true)
        var boardName: String = ""
        
        if segment.selectedSegmentIndex == 1 {
            if searchBar.text == "" {
                if indexPath.section == 0 {
                    addSubscribe["board"] = self.university[indexPath.row].board
                    boardName = self.university[indexPath.row].boardName
                } else if indexPath.section == 1 {
                    addSubscribe["board"] = self.faculty[indexPath.row].board
                    boardName = self.faculty[indexPath.row].boardName
                } else if indexPath.section == 2 {
                    addSubscribe["board"] = self.department[indexPath.row].board
                    boardName = self.department[indexPath.row].boardName
                }
            } else {
                if indexPath.section == 0 {
                    addSubscribe["board"] = self.newUniversity[indexPath.row].board
                    boardName = self.newUniversity[indexPath.row].boardName
                } else if indexPath.section == 1 {
                    addSubscribe["board"] = self.newFaculty[indexPath.row].board
                    boardName = self.newFaculty[indexPath.row].boardName
                } else if indexPath.section == 2 {
                    addSubscribe["board"] = self.newDepartment[indexPath.row].board
                    boardName = self.newDepartment[indexPath.row].boardName
                }
            }
            
            
            let alertController = UIAlertController(title: "구독", message: "\(boardName) \n \n 구독하시겠습니까?", preferredStyle: .alert)
            
            let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let okButton = UIAlertAction(title: "확인", style: .default) { alertAction in
                NetworkRequest.shared.request(api: .subscribes, method: .post, parameters: self.addSubscribe) { (error) in
                    if error == nil {
                        Storage.shared.getSubscribe {
                            self.searchTableview.reloadData()
                        }
                    } else {
                        let alert = UIAlertController(title: "구독실패", message: "구독에 실패하였습니다.", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            
            alertController.addAction(cancelButton)
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if segment.selectedSegmentIndex == 0 && indexPath.row == 0 {
            return false
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if segment.selectedSegmentIndex == 0 {
            if editingStyle == .delete {
                let subscribeId = Storage.shared.subscribes[indexPath.row].id
    //            let deleteSubscribe = Storage.shared.subscribes.remove(at: indexPath.row)
                Storage.shared.deleteSubscribe(subscribeId: subscribeId) { (error) in
                    if error == nil {
                        self.searchTableview.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        }
    }
    
    func search() {
        // 검색 정렬 필터
        let word = self.searchBar.text ?? ""
        
        newUniversity = university.filter { $0.universityName.contains(word) }
        newFaculty = faculty.filter { $0.facultyName.contains(word) }
        newDepartment = department.filter { $0.departmentName.contains(word) }

//        let newPosts = post.filter { $0.title.contains(word) || $0.content.contains(word) }
    }
    
    func getUniversity() {
        NetworkRequest.shared.requestArray(api: .universitys, method: .get, type: University.self) { (response) in
            self.university = response
            self.searchTableview.reloadData()
        }
    }
    
    func getFaculty() {
        NetworkRequest.shared
            .requestArray(api: .facultys, method: .get, type: Faculty.self, completion: { (response) in
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
