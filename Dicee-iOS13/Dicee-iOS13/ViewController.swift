//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // IBOutlet lets me access UI Elements by using Cntrl + drag and drop to attach it here.
    @IBOutlet weak var diceImageViewTwo: UIImageView!
    @IBOutlet weak var diceImageViewOne: UIImageView!

    let dies = [UIImage(named: "DiceOne"), UIImage(named: "DiceTwo"), UIImage(named: "DiceThree"), UIImage(named: "DiceFour"), UIImage(named: "DiceFive"), UIImage(named: "DiceSix")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        diceImageViewOne.image = UIImage(named:"DiceOne");
        diceImageViewTwo.image = UIImage(named:"DiceSix");
    }

    @IBAction func diceButtonPressed(_ sender: UIButton) {
        diceImageViewOne.image = dies[Int.random(in: 0...5)];
        diceImageViewTwo.image = dies[Int.random(in: 0...5)];
        
    }
    
}

