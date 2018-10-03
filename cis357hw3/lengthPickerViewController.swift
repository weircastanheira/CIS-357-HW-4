//
//  ViewController.swift
//  cis357hw3
//
//  Created by Filipe Castanheira & Michael Weir
//  on 9/17/18.
//  Copyright © 2018 Workbook. All rights reserved.
//

import UIKit

protocol lengthSelectionViewController{
    func settingsChanged(fromUnits: String, toUnits: String)


}

class lengthPickerViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var fromUnits: UILabel!
    
    @IBOutlet weak var toUnits: UILabel!
    
    
 //comment
    
    var delegate: lengthSelectionViewController?
    var selection: String = "Meters"
    var pickerData: [String] = [String]()
    var volumeData: [String] = [String]()
    var fromOrTo: Int = 0
    var whichMode: Int = 0
    var fromStr : String = "Meters"
    var toStr : String = "Meters"
    var fromLabel: String = ""
    var toLabel: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.isHidden = true
        self.volumeData = ["Gallons","Liters","Quarts"]
        self.pickerData = ["Meters", "Miles", "Yards"]
        self.picker.delegate = self
        self.picker.dataSource = self
        fromUnits.text = fromStr
        toUnits.text = toStr
        
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.fromPressed))
        fromUnits.isUserInteractionEnabled = true
        fromUnits.addGestureRecognizer(detectTouch)
        
        let detectTouch2 = UITapGestureRecognizer(target: self, action: #selector(self.toPressed))
        toUnits.isUserInteractionEnabled = true
        toUnits.addGestureRecognizer(detectTouch2)
        
        let detectTouch3 = UITapGestureRecognizer(target: self, action: #selector(self.self.hidePicker))
        self.view.addGestureRecognizer(detectTouch3)
    }

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    @objc func toPressed(){
        fromOrTo = 1
        unhidePicker()
    }

    @objc func fromPressed(){
        fromOrTo = 2
        unhidePicker()
    }
    
    @objc func hidePicker() {
        picker.isHidden = true
    }
    
    @objc func unhidePicker() {
        picker.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        
        delegate?.settingsChanged(fromUnits: fromUnits!.text!, toUnits: toUnits!.text!)
        dismiss(animated: true, completion: nil)
        
    }
    

}
    
extension lengthPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(whichMode == 1){
            return pickerData.count
        }
        if(whichMode == 2){
            return volumeData.count
        }
        return pickerData.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(whichMode == 1){
            return self.pickerData[row]
        }
        if(whichMode == 2){
            return self.volumeData[row]
        }
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (whichMode == 1){
            if(fromOrTo == 2){
                fromUnits.text = pickerData[row]
                fromLabel = pickerData[row]
                self.selection = pickerData[row]
            }
            if(fromOrTo == 1){
                toUnits.text = pickerData[row]
                toLabel = pickerData[row]
                self.selection = pickerData[row]
            }
        }
        if(whichMode == 2){
            if(fromOrTo == 2){
                fromUnits.text = volumeData[row]
                fromLabel = volumeData[row]
            }
            if(fromOrTo == 1){
                toUnits.text = volumeData[row]
                toLabel = volumeData[row]
            }
        }
    }
}



        
        
        
        
        


    













