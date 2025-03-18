//
//  CurrencyFormatter.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/16/25.
//

import UIKit

struct CurrencyFormatter {
    
    func makeAttributedCurrency(_ amount: Decimal) -> NSMutableAttributedString {
        
        let tuple = breakIntoDollarsAndCents(amount)
        return makeBalanceAtributed(dollars: tuple.0, cents: tuple.1)
    }
    
    //converts 929466.23 > "929,466" "23"
    func breakIntoDollarsAndCents(_ amount: Decimal) -> (String, String) {
        
        let tuple = modf(amount.doubleValue)
        let dollars = convertDollar(tuple.0)
        let cents = convertCents(tuple.1)
        
        return (dollars, cents)
    }
    
    // converts 929466 > "929,466"
    private func convertDollar(_ dollarPart: Double) -> String {
        
        let dollarsWithDecimal = dollarsFormatted(dollarPart) // "$929,466.00"
        let formatter = NumberFormatter()
        let decimalSeparator = formatter.decimalSeparator! // "."
        let dollarCompents = dollarsWithDecimal.components(separatedBy: decimalSeparator) // "$929,466" "00"
        var dollars = dollarCompents.first! // "$929,466"
        dollars.removeFirst() // "929,466"
        
        return dollars
    }
    
    private func convertCents(_ centPart: Double) -> String {
        
        let cents: String
        if centPart == 0 {
            cents = "00"
        } else {
            cents = String(format: "%.0f", centPart * 100)
        }
        
        return cents
        
    }
    
    func dollarsFormatted(_ dollars: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: dollars as NSNumber) {
            return result
        }
        
        return ""
    }
    
    private func makeBalanceAtributed(dollars: String, cents: String) -> NSMutableAttributedString {
        
        let dollasSignAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.preferredFont(forTextStyle: .callout),
            .baselineOffset: 9]
        let dollarAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .title1)
        ]
        let centAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .callout),
            .baselineOffset: 8
        ]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollasSignAttributes)
        rootString.append(NSAttributedString(string: dollars, attributes: dollarAttributes))
        rootString.append(NSAttributedString(string: cents, attributes: centAttributes))
        
        return rootString
    }
}
