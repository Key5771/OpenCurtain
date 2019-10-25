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
    
    var pickColleage = ["공과대학", "경상대학", "자연대학", "간호대학"]
    var pickMajor = ["컴퓨터공학전공", "에너지공학과", "메카트로닉스공학전공", "무역학과", "경제학과", "수학과", "화학과", "물리학과", "간호학과"]
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
        toolbar.setItems([cancelButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        colleageTextfield.inputView = pickerView1
        colleageTextfield.inputAccessoryView = toolbar
        
        majorTextfield.inputView = pickerView2
        majorTextfield.inputAccessoryView = toolbar
    }
    
    @objc func donePicker() {
        colleageTextfield.resignFirstResponder()
        majorTextfield.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1{
            return pickColleage.count
        } else if pickerView == pickerView2 {
            return pickMajor.count
        }
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return pickColleage[row]
        } else if pickerView == pickerView2 {
            return pickMajor[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            colleageTextfield.text = pickColleage[row]
        } else if pickerView == pickerView2 {
            majorTextfield.text = pickMajor[row]
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
