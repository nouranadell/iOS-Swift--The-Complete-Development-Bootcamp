//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         UIUpdate()
    }
    
    
    
    @IBAction func answerPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let  userGotItRight = quizBrain.checkAnswer(userAnswer)
        
        if userGotItRight {
            
            sender.backgroundColor = UIColor.green
        }
        
        else {
            sender.backgroundColor = UIColor.red
        
        }
        
        quizBrain.nextQuestion()
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.UIUpdate()
            
        }
        /* OR use timer
         timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: false)
        */
        
    }

    

// if timer used instead of dispatch, write @objc before fun here
    func UIUpdate(){
    
        question.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        let choices = quizBrain.getChoice()
        thirdButton.setTitle(choices[0], for: .normal)
        trueButton.setTitle(choices[1], for: .normal)
        falseButton.setTitle(choices[2], for: .normal)
        
        thirdButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        trueButton.backgroundColor = UIColor.clear
        }
        
    
    
}

