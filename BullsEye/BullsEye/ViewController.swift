//
//  ViewController.swift
//  BullsEye
//
//  Created by Suraphel on 2/15/22.
//

import UIKit

class ViewController: UIViewController {
    var sliderCurrentValue: Int = 50
    @IBOutlet var slider: UISlider!
    @IBOutlet var target: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var targetValue = 0
    var points = 0
    var score = 0
    var counter = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateValue()
        startNewRound()
        sliderCurrentValue = lroundf(slider.value)
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)

        let thumbImageHighlighted = UIImage(
          named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)

        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    }

    @IBAction func showAlert() {
        var title: String
        let difference = abs(targetValue - sliderCurrentValue)
        points = 100 - difference
        let message = "You scored \(points) points \n"
        
        if difference == 0 {
            title = "Perfect!"
        }
        else if difference < 5 {
            title = "You almost had it!"
        }
        else if difference < 10 {
            title = "Pretty good!"
        }
        else {
            title = "Not even close..."
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default){_ in
           self.updateValue()
        }
        
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        startNewRound()
    }
    
    @IBAction func startNewGame(_ sender: Any) {
        startOver()
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(
          name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    @IBAction func slideMoved(_ slider: UISlider) {
        sliderCurrentValue = lroundf(slider.value)
    }
    func startNewRound(){
        sliderCurrentValue = lroundf(slider.value)
        slider.value = Float(sliderCurrentValue)
    }
    func updateValue(){
        targetValue = Int.random(in: 1...100)
        target.text = String(targetValue)
        score += points
        totalScore.text = String(score)
        counter += 1
        roundLabel.text = String(counter)
    }
    func startOver() {
        slider.value = 50
        counter = 1
        score = 0
        roundLabel.text = String(counter)
        totalScore.text = String(score)
        targetValue = Int.random(in: 1...100)
        target.text = String(targetValue)
    }
}

