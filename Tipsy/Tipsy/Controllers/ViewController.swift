import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var people: UILabel!
    @IBOutlet weak var billValue: UITextField!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var zeroPctButton: UIButton!
    
    var tipPercentage: Double = 0.1
    var tipsy = Tipsy()
    @IBAction func tipSelected(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        switch sender {
        case zeroPctButton:
            tipPercentage = 0.0
        case tenPctButton:
            tipPercentage = 0.1
        case twentyPctButton:
            tipPercentage = 0.2
        default:
            break
        }
        
        billValue.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        people.text = "\(value)"
        billValue.endEditing(true)
    }
    
    @IBAction func CalculateClicked(_ sender: UIButton) {
        guard let billAmount = Double(billValue.text ?? ""),
              let numberOfPeople = Int(people.text ?? "2") else {
            // Handle invalid input
            return
        }
        
        
        let amountPerPerson = tipsy.calculateSplit(bill: billAmount, tip: tipPercentage, split: numberOfPeople)
        
        // Perform the segue and pass the calculated result to the next view controller
        performSegue(withIdentifier: "goToResults", sender: self)
        
        // Optionally, store the result in a variable or pass it to the next controller
        print("Each person pays: \(amountPerPerson)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = tipsy.getTotal()
            destinationVC.summaryText = "Split between \(tipsy.getSplit()) people with \(Int(tipsy.getTip()*100))% tip"
        }
    }
}
