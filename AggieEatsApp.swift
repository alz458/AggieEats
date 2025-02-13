//
//  AggieEatsApp.swift
//  AggieEats
//

import SwiftUI
import Stripe

@main
struct AggieEatsApp: App {
    init() {
        StripeAPI.defaultPublishableKey = "pk_test_51Qr5mlF7Li0xaTIF7dSPQbeasc3GJcxTpjgUvwxF09qKtwjsa8h6XPoxwIqv4g5U7D1hIqtnZtNRyyouNnIMDaZN00JpAq18jL"
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
