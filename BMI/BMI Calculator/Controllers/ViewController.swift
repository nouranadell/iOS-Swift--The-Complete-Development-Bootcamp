//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heughtSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    var calculatorBrain = CalculatorBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderChange(_ sender: UISlider) {
     let  height=String(format: "%.2f", sender.value)
        heightLabel.text = "\(height)m"
    }
    
    @IBAction func weightSliderChange(_ sender: UISlider) {
        let weight=Int(sender.value)
        weightLabel.text = "\(String(weight))Kg"
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heughtSlider.value
        let weight = weightSlider.value
        calculatorBrain.calculateBMI(height: height , weight : weight)
        
//        let secondVC = SecondViewController()
//        secondVC.bmiValue = String(format: "%.1f",BMI)
//        self.present(secondVC, animated: true, completion: nil)
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"
        {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorBrain.getBMI()
            destinationVC.bmiColor = calculatorBrain.getBMI_color()
            destinationVC.bmiAdvice = calculatorBrain.getBMI_advice()
        }
    }
    
}

