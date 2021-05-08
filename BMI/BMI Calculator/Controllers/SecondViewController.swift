//
//  SecondViewController.swift
//  BMI Calculator
//
//  Created by Nouran Adel on 6/15/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//




//------------------THIS FILE IS NOT USED , IT WAS JUST FOR LEARNING PURPOSES---------------------------
import UIKit
class SecondViewController : UIViewController {
           var bmiValue = "0.0"
    override func viewDidLoad() {
        super.viewDidLoad()
         
        view.backgroundColor = UIColor.purple
        let label = UILabel( )
        label.text = bmiValue
        label.frame=CGRect (x: 0, y: 0 , width: 100, height: 50 )
        view.addSubview(label)
        
        
        
    }
    
    
    
    
}
