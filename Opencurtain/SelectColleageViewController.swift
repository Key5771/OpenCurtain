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
    
    func getFaculty() {
        NetworkRequest.shared.request(api: .facultys, method: .get, type: Facultys.self) { (results) in
            self.pickFaculty = results
        }
    }
    
    func getMajor() {
        NetworkRequest.shared.request(api: .departments, method: .get, type: Departments.self) { (results) in
            self.pickDepartment = results
        }
    }
    
    @objc func donePicker() {
        colleageTextfield.text = pickFaculty[pickerView1.selectedRow(inComponent: 0)].facultyName
        majorTextfield.text = pickDepartment[pickerView2.selectedRow(inComponent: 0)].departmentName
        colleageTextfield.resignFirstResponder()
        majorTextfield.resignFirstResponder()
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
