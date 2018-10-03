//
//  ViewController.swift
//  cis357hw3
//
//  Created by Filipe Castanheira & Michael Weir
//  on 9/17/18.
//  Copyright © 2018 Workbook. All rights reserved.
//

import UIKit



class toUnitsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate{
    
    

    
    
    let lengths = ["Meters", "Miles", "Yards"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.isHidden = true
        
        
        
        let detectTouch2 = UITapGestureRecognizer(target: self, action: #selector(self.unhidePicker))
        toUnits.isUserInteractionEnabled = true
        toUnits.addGestureRecognizer(detectTouch2)
        
        
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func hidePicker() {
        picker.isHidden = true
        //  self.view.endEditing(true)
    }
    
    @objc func unhidePicker() {
        picker.isHidden = false
        //  self.view.endEditing(true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lengths.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.lengths[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        toUnits.text = lengths[row]
    }
    
    
    //    if fromUnits.isUserInteractionEnabled == true{
    //    fromUnits.text = lengths[row]
    //    fromUnits.isUserInteractionEnabled = false
    //    }
    //    else if toUnits.isUserInteractionEnabled == true{
    //    toUnits.text = lengths[row]
    //    toUnits.isUserInteractionEnabled = false
    //    }
    
    
}





















