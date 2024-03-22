//
//  FinancialFormulae.swift
//  MortgageLabApp
//
//  Created by Philip Trwoga on 14/11/2023.
//

import Foundation

class FinancialFormulae {
    
    private var totalAmount:Double = 0.0
    
    func mortgageCalculator(_ monthlyPayment: String, _ interestRate: String,_ loanDuration: String) -> Double{
        
        if let theMonthlyPayment = Double(monthlyPayment), let theInterestRate = Double(interestRate), let theLoanDuration = Int(loanDuration){
            
            let r = theInterestRate / 100
            print("Interest rate as fraction = \(r)")
            
            let A = (r / 12) + 1
            print("A = \(A)")
            
            let n = Double(theLoanDuration * 12)
            print("Total number of payments = \(n)")
            
            let top = theMonthlyPayment * (pow(A,(n)) - 1 ) * (pow(A,(-n)))
            
            let bottom = r / 12
            
            totalAmount = top/bottom
            print("Total amount that can be borrowed = \(totalAmount)")
        }
        
        return totalAmount
    }
    
    
    
}
