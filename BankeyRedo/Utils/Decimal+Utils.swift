//
//  DecimalUtils.swift
//  BankeyRedo
//
//  Created by Todd Smith on 3/16/25.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
