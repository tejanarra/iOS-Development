//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Teja Narra on 10/7/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var bmiResult: String?
    var bmiAdvice: String?
    var color: UIColor?

    @IBOutlet weak var advice: UILabel!
    @IBOutlet weak var result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        result.text = bmiResult
        advice.text = bmiAdvice
        view.backgroundColor = color
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true)
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
