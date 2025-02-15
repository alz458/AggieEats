//
//  OrderCompletion.swift
//  AggieEats
//

import SwiftUI
import Stripe

struct OrderCompletion: View {
    @Binding var total: Decimal
    @State private var message: String = ""
    @State var paymentMethodParams: STPPaymentMethodParams?
    let paymentGatewayController = PaymentGatewayController()
    
    func pay() {
        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else {
            message = "no client secret"
            return
        }
        
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        paymentGatewayController.submitPayment(intent:paymentIntentParams) {
            status, intent, error in
            print(error)
            
            switch status {
            case .failed:
                message = "Failed"
            case .canceled:
                message = "Cancelled"
            case .succeeded:
                message = "Your payment has been successfully completed!"
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order Summary")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
            TotalView(total: $total) // from ConfirmOrderView.swift file
                .padding(.bottom)
            Section {
                // Stripe Credit Card TextField Here
                // TODO: Credit card text field
                STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams)
            } header: {
                Text("Payment Information")
            }
            
            Button {
                pay()
            } label: {
                Text("Place Your Order")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .controlSize(.large)
            .padding(.bottom)
            
            Text(message)
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    OrderCompletion(total: .constant(1.00))
}
