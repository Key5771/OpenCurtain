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
    var addSubscribe: [String:Int] = [:]
    
    var cellCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableview.delegate = self
        searchTableview.dataSource = self

        // Do any additional setup after loading the view.
        Storage.shared.getSubscribe { }
        getUniversity()
        getFaculty()
        getDepartment()
        
    }
    
    @IBAction func segmentTap(_ sender: UISegmentedControl) {
        searchTableview.reloadData()
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
                cellCount = university.count
            } else if section == 1 {
                cellCount = faculty.count
            } else if section == 2 {
                cellCount = department.count
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
                cell.label.text = university[indexPath.row].universityName
                if boards.contains(university[indexPath.row].board) {
                    cell.subscribeLabel.isHidden = false
                } else {
                    cell.subscribeLabel.isHidden = true
                }
            } else if indexPath.section == 1 {
                cell.label.text = faculty[indexPath.row].facultyName
                if boards.contains(self.faculty[indexPath.row].board) {
                    cell.subscribeLabel.isHidden = false
                } else {
                    cell.subscribeLabel.isHidden = true
                }
            } else if indexPath.section == 2 {
                cell.label.text = department[indexPath.row].departmentName
                if boards.contains(self.department[indexPath.row].board) {
                    cell.subscribeLabel.isHidden = false
                } else {
                    cell.subscribeLabel.isHidden = true
                }
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTableview.deselectRow(at: indexPath, animated: true)
        if segment.selectedSegmentIndex == 1 {
            if indexPath.section == 0 {
                addSubscribe["board"] = self.university[indexPath.row].board
            } else if indexPath.section == 1 {
                addSubscribe["board"] = self.faculty[indexPath.row].board
            } else if indexPath.section == 2 {
                addSubscribe["board"] = self.department[indexPath.row].board
            }
            
            let alertController = UIAlertController(title: "구독", message: "구독하시겠습니까?", preferredStyle: .alert)
            
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
