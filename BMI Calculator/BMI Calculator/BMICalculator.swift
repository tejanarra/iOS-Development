//
//  BMICalculator.swift
//  BMI Calculator
//
//  Created by Teja Narra on 10/7/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

struct BMICalculator {
    var bmi = 0.0
    var height: Float = 1.5
    var weight: Float = 100.0
    
    mutating func calculateBMI() {
        bmi = Double(weight) / (Double(height) * Double(height))
    }

    func getAdvice() -> String {
        switch bmi {
        case ..<18.5:
            return "Underweight: Consider seeking guidance to gain weight."
        case 18.5..<24.9:
            return "Normal weight: Keep up the healthy habits!"
        case 25..<29.9:
            return "Overweight: Focus on a balanced diet and exercise."
        default:
            return "Obesity: Consult a healthcare provider for a plan."
        }
    }

    func getColor() -> UIColor {
        switch bmi {
        case ..<18.5:
            return UIColor.blue // Underweight
        case 18.5..<24.9:
            return UIColor.green // Normal weight
        case 25..<29.9:
            return UIColor.yellow // Overweight
        default:
            return UIColor.red // Obesity
        }
    }

    func getBMI() -> String {
        return String(format: "%.2f", bmi)
    }
}
