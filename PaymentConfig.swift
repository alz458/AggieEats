//
//  PaymentConfig.swift
//  AggieEats
//

import Foundation

class PaymentConfig {
    
    var paymentIntentClientSecret: String? // stores client secret
    static var shared: PaymentConfig = PaymentConfig() // makes the instance global
    
    private init() { }
}
