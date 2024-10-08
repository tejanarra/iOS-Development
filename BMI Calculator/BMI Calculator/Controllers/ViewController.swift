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
    var calculator = BMICalculator()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func weightSlider(_ sender: UISlider) {
        weightLabel.text=String(format: "%.0f", sender.value)+"kg"
        calculator.weight=sender.value
    }
    @IBAction func heightSlider(_ sender: UISlider) {
        heightLabel.text=String(format: "%.2f", sender.value)+"m"
        calculator.height=sender.value
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        calculator.calculateBMI()  // This updates the bmi property
        performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToResults") {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiResult = calculator.getBMI()    // Getting the formatted BMI
            destinationVC.bmiAdvice = calculator.getAdvice()  // Getting the updated advice
            destinationVC.color = calculator.getColor();      // Getting the color based on updated BMI
        }
    }
    
    
}

