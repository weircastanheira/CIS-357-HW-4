//
//  ConversionCalcTextField.swift
//  cis357hw3
//
//  Created by CIS Student on 9/30/18.
//  Copyright © 2018 Workbook. All rights reserved.
//

import UIKit

class ConversionCalcTextField: DecimalMinusTextField {

    override func awakeFromNib() {
        self.tintColor = FOREGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
        
        self.textColor = FOREGROUND_COLOR
        self.backgroundColor = UIColor.clear
        self.borderStyle = .roundedRect
        
        guard let ph = self.placeholder else {
            return
        }
        
        self.attributedPlaceholder = NSAttributedString(string: ph, attributes: [NSAttributedStringKey.foregroundColor: FOREGROUND_COLOR])
        
    }

}
