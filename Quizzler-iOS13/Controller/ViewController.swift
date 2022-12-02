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
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var upperButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressBar.progress = 0.0
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        //let actualAnswer = quiz[questionNumber].answer
        
        if quizBrain.checkAnswer(userAnswer) {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.increaseQuestionNumber()
        
        if quizBrain.getQuestionNumber() == 0 {
            showMessage(title: "Game Over!", message: "You have scored \(quizBrain.getScore()) points!")
            quizBrain.resetScore()
        }
        
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        //questionLabel.text = quiz[questionNumber].text
        //progressBar.progress = Float(questionNumber + 1) / Float(quiz.count)
        questionLabel.text = quizBrain.getQuestionText()
        upperButton.setTitle(quizBrain.getAnswerText(0), for: .normal)
        middleButton.setTitle(quizBrain.getAnswerText(1), for: .normal)
        bottomButton.setTitle(quizBrain.getAnswerText(2), for: .normal)
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        upperButton.backgroundColor = UIColor.clear
        middleButton.backgroundColor = UIColor.clear
        bottomButton.backgroundColor = UIColor.clear
    }
    
    func showMessage(title: String, message: String ) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: {(action) -> Void in})
        dialogMessage.addAction(okButton)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

