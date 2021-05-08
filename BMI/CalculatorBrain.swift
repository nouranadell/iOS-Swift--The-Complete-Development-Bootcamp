//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Nouran Adel on 6/15/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit
struct CalculatorBrain{
    var bmiVAL: BMI?
    
   mutating func calculateBMI( height: Float , weight: Float ){
        
     let value_BMI = weight / pow(height,2)
    if value_BMI < 18.5
    {
       bmiVAL = BMI(value: value_BMI, advice: "Eat More Pies!", color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    }
    else if value_BMI < 24.9
    {
        bmiVAL = BMI(value: value_BMI, advice: "Fit as a fiddle!", color: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
    }
    else {
         bmiVAL = BMI(value: value_BMI, advice: "Eat Less Pies!", color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
    }
    
        
    }
    
    func getBMI() -> String{
        let bmivalue = String(format: "%.1f", bmiVAL?.value ?? 0.0)
        return bmivalue
    }
    func getBMI_advice() -> String{
        let bmiadvice =  bmiVAL?.advice ?? "0.0"
        return bmiadvice
    }
    func getBMI_color() -> UIColor {
        let bmicolor =  bmiVAL?.color
        return bmicolor!
    }
}
