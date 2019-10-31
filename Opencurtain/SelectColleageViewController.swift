//
//  SelectColleageViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/25.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class SelectColleageViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var colleageTextfield: UITextField!
    @IBOutlet weak var majorTextfield: UITextField!
    
    var pickFaculty: [Faculty] = []
    var pickDepartment: [Department] = []
    
    var user = User()
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getFaculty()
        getMajor()
        
        nextButton.layer.cornerRadius = 5
        
        pickerView1.tag = 1
        pickerView2.tag = 2
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton, space, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        colleageTextfield.inputView = pickerView1
        colleageTextfield.inputAccessoryView = toolbar
        
        majorTextfield.inputView = pickerView2
        majorTextfield.inputAccessoryView = toolbar
    }
    
    @IBAction func nextClick(_ sender: Any) {
        postUser()
    }
    
    func postUser() {
        NetworkRequest.shared.request(api: .users, method: .post, parameters: user.toJSON()) { (error) in
            if error == nil {
                let viewController = self.storyboard?.instantiateViewController(identifier: "signUpFinish") as? SignupFinishViewController
                
                self.navigationController?.pushViewController(viewController!, animated: true)
            } else {
                print("\(error)")
            }
        }
    }
    
    
    func getFaculty() {
        NetworkRequest.shared.requestArray(url: "/facultys/\(user.university)", method: .get, type: Faculty.self) { (results) in
            self.pickFaculty = results
            self.pickerView1.reloadAllComponents()
        }
    }
    
    func getMajor() {
        NetworkRequest.shared.requestArray(url: "/departments/\(user.faculty)", method: .get, type: Department.self) { (results) in
            self.pickDepartment = results
            self.pickerView2.reloadAllComponents()
        }
    }
    
    @objc func donePicker() {
        if colleageTextfield.isFirstResponder {
            colleageTextfield.text = pickFaculty[pickerView1.selectedRow(inComponent: 0)].facultyName
            colleageTextfield.resignFirstResponder()
            getMajor()
        } else {
            majorTextfield.text = pickDepartment[pickerView2.selectedRow(inComponent: 0)].departmentName
            majorTextfield.resignFirstResponder()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1{
            return pickFaculty.count
        } else if pickerView == pickerView2 {
            return pickDepartment.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            self.user.faculty = String(pickFaculty[row].id)
        } else if pickerView == pickerView2 {
            self.user.department = String(pickDepartment[row].id)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return pickFaculty[row].facultyName
        } else if pickerView == pickerView2 {
            return pickDepartment[row].departmentName
        }
        return ""
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == pickerView1 {
//            colleageTextfield.text = pickColleage[row].
//        } else if pickerView == pickerView2 {
//            majorTextfield.text = pickMajor[row]
//        }
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
