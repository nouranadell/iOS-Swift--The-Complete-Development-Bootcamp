//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Nouran Adel on 6/15/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    var bmiValue : String?
    var bmiAdvice : String?
    var bmiColor : UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text=bmiValue
        adviceLabel.text=bmiAdvice
        view.backgroundColor=bmiColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
    //back to previous page
        dismiss(animated: true, completion: nil)
    
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
