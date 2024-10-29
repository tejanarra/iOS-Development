import UIKit

class ViewController: UIViewController {
    
    var isTyping = false
    var number1: Double = 0.0
    var number2: Double = 0.0
    var tempNumber: Double = 0.0
    var operation: String = ""
    var tempString: String = ""
    
    @IBOutlet weak var displayLabel: UILabel!

    // Computed properties for each operation
    var sum: Double {
        return number1 + number2
    }

    var subtract: Double {
        return number1 - number2
    }

    var multiply: Double {
        return number1 * number2
    }

    var divide: Double {
        return number2 != 0 ? number1 / number2 : Double.nan // Handle division by zero
    }

    var percentage: Double {
        return number1 / 100
    }
    
    var result: Double = 0.0

    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        if let operationSymbol = sender.titleLabel?.text {
            switch operationSymbol {
            case "AC":
                // Reset all values
                displayLabel.text = "0"
                resetCalculator()
            case "=":
                // Set number2 and calculate the result
                number2 = tempNumber
                calculate()
                operation = "" // Clear the operation after calculating
            case "+/-":
                // Toggle sign for the current number
                tempNumber = -tempNumber
                displayLabel.text = formatDisplay(tempNumber)
            case "+", "-", "×", "÷", "%":
                // Handle operations and store the operation
                if operation.isEmpty {
                    if result == 0.0{
                        number1 = tempNumber
                    }else {
                        number1 = result
                    }
                     // Store tempNumber as number1
                } else {
                    number2 = tempNumber // Store tempNumber as number2
                    calculate() // Calculate the result before updating operation
                }
                operation = operationSymbol
                tempNumber = 0.0
                tempString = ""
                displayLabel.text = "\(formatDisplay(number1)) \(operation) " // Display the current operation
            default:
                break
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if !isTyping {
            displayLabel.text = ""
            isTyping = true
        }
        tempString += sender.titleLabel?.text ?? "0"
        displayLabel.text! += sender.titleLabel?.text ?? "0"
        tempNumber = Double(tempString) ?? 0.0
    }
    
    func calculate() {
        
        
        switch operation {
        case "+":
            result = sum
        case "-":
            result = subtract
        case "×":
            result = multiply
        case "÷":
            result = divide.isNaN ? 0.0 : divide // Show 0 for division by zero
        case "%":
            result = percentage
        default:
            break
        }
        
        // Display result or error
        if operation == "÷" && number2 == 0 {
            displayLabel.text = "Error"
        } else {
            displayLabel.text = formatDisplay(result)
            number1 = result // Store result as number1 for chaining calculations
            operation = "" // Clear the operation after calculation
            tempNumber = 0.0 // Reset tempNumber for new input
            tempString = ""
            isTyping = false // Allow new input
        }
    }
    
    func resetCalculator() {
        number1 = 0.0
        number2 = 0.0
        tempNumber = 0.0
        tempString = ""
        operation = ""
        isTyping = false
    }

    // Helper function to format display
    func formatDisplay(_ value: Double) -> String {
        // Check if value is a whole number
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value)) // Display as integer
        } else {
            return String(value) // Display as double
        }
    }
}
