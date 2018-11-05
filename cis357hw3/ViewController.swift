//
//  ViewController.swift
//  cis357hw3
//
//  Created by Filipe Castanheira & Michael Weir
//  on 9/17/18.
//  Copyright © 2018 Workbook. All rights reserved.
//

import UIKit



class ViewController: ConversionCalcViewController, UITextFieldDelegate, lengthSelectionViewController, HistoryTableViewControllerDelegate {


    @IBOutlet weak var titleConvCalc: UILabel!
    @IBOutlet weak var input: UILabel!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var yardsField: DecimalMinusTextField!
    @IBOutlet weak var metersField: DecimalMinusTextField!
    var mode: String? = CalculatorMode.Length.rawValue
    var whatMode: Int = 1
    var entries : [Conversion] = [
        Conversion(fromVal: 1, toVal: 1760, mode: .Length, fromUnits: LengthUnit.Miles.rawValue, toUnits:
            LengthUnit.Yards.rawValue, timestamp: Date.distantPast),
        Conversion(fromVal: 1, toVal: 4, mode: .Volume, fromUnits: VolumeUnit.Gallons.rawValue, toUnits:
            VolumeUnit.Quarts.rawValue, timestamp: Date.distantFuture)]
    
    //  HW#8: Part 01, Step 3
    func selectEntry(entry: Conversion) {
        self.yardsField.text = String(entry.fromVal)
        self.metersField.text = String(entry.toVal)
        self.mode = entry.mode.rawValue
        self.input.text = entry.fromUnits
        self.output.text = entry.toUnits
    }
    
    func settingsChanged(fromUnits: String, toUnits: String) {
        input.text = fromUnits
        output.text = toUnits
        
        if(whatMode == 1) {
            yardsField.placeholder = "Enter length in \(input.text!)"
            metersField.placeholder = "Enter length in \(output.text!)"
            yardsField.attributedPlaceholder = NSAttributedString(string: yardsField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: FOREGROUND_COLOR])
            metersField.attributedPlaceholder = NSAttributedString(string: metersField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: FOREGROUND_COLOR])
        }
        else if(whatMode == 2) {
            yardsField.placeholder = "Enter volume in \(input.text!)"
            metersField.placeholder = "Enter volume in \(output.text!)"
            yardsField.attributedPlaceholder = NSAttributedString(string: yardsField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: FOREGROUND_COLOR])
            metersField.attributedPlaceholder = NSAttributedString(string: metersField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: FOREGROUND_COLOR])
        }
        
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // When we click on one of the textboxes it clears both of them
        //self.yardsField.delegate = self
        //self.metersField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // dismiss keyboard when tapping outside oftext fields
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "historySegue") {
            let dest = segue.destination as? HistoryTableViewController
            dest!.entries = self.entries
            dest?.historyDelegate = self
        }
        
        if let dest = segue.destination as? lengthPickerViewController{
            dest.whichMode = whatMode
//            dest.fromUnits = input
//            dest.toUnits = output]
            dest.fromStr = input.text!
            dest.toStr = output.text!
            dest.delegate = self
        }
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
//        entries.append(Conversion(fromVal: Double(self.yardsField.text!)!, toVal: Double(self.metersField.text!)!, mode: CalculatorMode(rawValue: mode!)!, fromUnits: self.input.text!, toUnits: self.output.text!, timestamp: Date.init()))

        if self.yardsField.text == "" && self.metersField.text != "" {
            if mode! == CalculatorMode.Length.rawValue{
                let i = LengthUnit(rawValue: self.input.text!)
                let j = LengthUnit(rawValue: self.output.text!)
                let key = LengthConversionKey(toUnits: i!, fromUnits: j!)
                let jDouble = Double(self.metersField.text!)
                let calc = jDouble! * lengthConversionTable[key]!
                self.yardsField.text = String(calc)
                
                entries.append(Conversion(fromVal: Double(self.yardsField.text!)!, toVal: Double(self.metersField.text!)!, mode: CalculatorMode(rawValue: mode!)!, fromUnits: self.input.text!, toUnits: self.output.text!, timestamp: Date.init()))
            }
            else if mode! == CalculatorMode.Volume.rawValue {
                let i = VolumeUnit(rawValue: self.input.text!)
                let j = VolumeUnit(rawValue: self.output.text!)
                let key = VolumeConversionKey(toUnits: i!, fromUnits: j!)
                let jDouble = Double(self.metersField.text!)
                let calc = jDouble! * volumeConversionTable[key]!
                self.yardsField.text = String(calc)
                
                entries.append(Conversion(fromVal: Double(self.yardsField.text!)!, toVal: Double(self.metersField.text!)!, mode: CalculatorMode(rawValue: mode!)!, fromUnits: self.input.text!, toUnits: self.output.text!, timestamp: Date.init()))
            }
            else{
                print("Error calculating")
            }
        }
        else if self.yardsField.text != "" && self.metersField.text == "" {
            if mode! == CalculatorMode.Length.rawValue {
                let i = LengthUnit(rawValue: self.input.text!)
                let j = LengthUnit(rawValue: self.output.text!)
                let key = LengthConversionKey(toUnits: j!, fromUnits: i!)
                let jDouble = Double(self.yardsField.text!)
                let calc = jDouble! * lengthConversionTable[key]!
                self.metersField.text = String(calc)
                
                entries.append(Conversion(fromVal: Double(self.yardsField.text!)!, toVal: Double(self.metersField.text!)!, mode: CalculatorMode(rawValue: mode!)!, fromUnits: self.input.text!, toUnits: self.output.text!, timestamp: Date.init()))
            }
            else if mode! == CalculatorMode.Volume.rawValue{
                let i = VolumeUnit(rawValue: self.input.text!)
                let j = VolumeUnit(rawValue: self.output.text!)
                let key = VolumeConversionKey(toUnits: j!, fromUnits: i!)
                let jDouble = Double(self.yardsField.text!)
                let calc = jDouble! * volumeConversionTable[key]!
                self.metersField.text = String(calc)
                
                entries.append(Conversion(fromVal: Double(self.yardsField.text!)!, toVal: Double(self.metersField.text!)!, mode: CalculatorMode(rawValue: mode!)!, fromUnits: self.input.text!, toUnits: self.output.text!, timestamp: Date.init()))
            }
            else{
                print("Error calculating")
            }
        }
        else{
            print("Enter a value in a field!")
            self.yardsField.text = ""
            self.metersField.text = ""
        }
        dismissKeyboard()
        }
    
    
    @IBAction func modePressed(_ sender: Any) {
        if mode! == CalculatorMode.Length.rawValue {
            whatMode = 2
            mode = CalculatorMode.Volume.rawValue
            input.text = VolumeUnit.Gallons.rawValue
            output.text = VolumeUnit.Liters.rawValue
            titleConvCalc.text = "Volume Converter Calculator"
            yardsField.placeholder = "Enter volume in \(input.text!)"
            metersField.placeholder = "Enter volume in \(output.text!)"
        }
        else if mode! == CalculatorMode.Volume.rawValue{
            whatMode = 1
            mode = CalculatorMode.Length.rawValue
            input.text = LengthUnit.Yards.rawValue
            output.text = LengthUnit.Meters.rawValue
            titleConvCalc.text = "Length Converter Calculator"
            yardsField.placeholder = "Enter length in \(input.text!)"
            metersField.placeholder = "Enter length in \(output.text!)"
        }
        else{
            print("Error choosing mode")
        }
        
        yardsField.text = ""
        metersField.text = ""
        
        yardsField.attributedPlaceholder = NSAttributedString(string: yardsField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: FOREGROUND_COLOR])
        metersField.attributedPlaceholder = NSAttributedString(string: metersField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: FOREGROUND_COLOR])
        
        dismissKeyboard()
    }
    
 
    @IBAction func clearPressed(_ sender: Any) {
        metersField.text = ""
        yardsField.text = ""
    }
    
/*
    // Idea from
    // https://stackoverflow.com/questions/37084537/how-to-clear-text-field
    func textFieldDidBeginEditing(_ textField: DecimalMinusTextField) {
        yardsField.text = ""
        metersField.text = ""
    }
*/

}
