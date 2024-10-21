import Foundation
struct CurrencyModel{
    let from: String
    let to: String
    let rate: Double
    
    func getRate() -> String{
        return String(format: "%.2f", rate)
    }
}
