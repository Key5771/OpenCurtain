//
//  SelectUniversityViewController.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/25.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class SelectUniversityViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var universityTextfield: UITextField!
    
    let pickerView = UIPickerView()
    
    var user = User()
    
//    var pickUniversity = ["제주대학교", "제주한라대학교", "제주관광대학교", "제주국제대학교"]
    var pickUniversity: [University] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getUniversity()
        
        nextButton.layer.cornerRadius = 5
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton, space, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        universityTextfield.inputView = pickerView
        universityTextfield.inputAccessoryView = toolbar
    }
    
    @IBAction func nextClick(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(identifier: "selectColleage") as? SelectColleageViewController
        
        viewController?.user = self.user
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    
    func getUniversity() {
        NetworkRequest.shared.requestArray(api: .universitys, method: .get, type: University.self) { (results) in
            self.pickUniversity = results
            print(results)
        }
    }
    
    @objc func donePicker() {
        guard pickUniversity.count > 0 else { return }
        universityTextfield.text = pickUniversity[pickerView.selectedRow(inComponent: 0)].universityName
        universityTextfield.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickUniversity.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.user.university = String(pickUniversity[row].id)
        return pickUniversity[row].universityName
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        universityTextfield.text = pickUniversity[row]
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
