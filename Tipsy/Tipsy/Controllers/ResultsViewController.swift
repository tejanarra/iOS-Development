//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Teja Narra on 10/7/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var result: String?
    var summaryText: String?

    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var resultValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        summary.text = summaryText
        resultValue.text = result
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
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
