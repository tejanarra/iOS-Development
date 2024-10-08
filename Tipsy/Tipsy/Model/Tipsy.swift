import UIKit

struct Tipsy {
    var selects: Selections?
    
    mutating func calculateSplit(bill: Double, tip: Double, split: Int) -> String {
        // Initialize the selections with the provided values
        self.selects = Selections(bill: bill, tip: tip, split: Double(split))
        
        guard let selects = selects else { return "0.00" }
        
        // Calculate total amount per person
        let totalAmount = (selects.bill + (selects.bill * selects.tip)) / selects.split
        self.selects?.total=totalAmount
        return String(format: "%.2f", totalAmount)
    }
    
    // Use formatting to return string representations
    func getSplit() -> String {
        return String(format: "%.2f", selects?.split ?? 0.0)
    }
    
    func getTotal() -> String {
        return String(format: "%.2f", selects?.total ?? 0.0)
    }
    
    func getTip() -> Double {
        return selects?.tip ?? 0.0
    }
}
