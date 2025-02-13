//
//  MenuOptionsView.swift
//  AggieEats
//

import SwiftUI
import OrderedCollections

struct MenuOptionsView: View {
    @State var menuItems: OrderedDictionary<String, [String]>
    
    var body: some View {
        ForEach(menuItems.keys, id: \.self) { key in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("Menu Options Color"))
                    .frame(height: 130)
                VStack(alignment: .leading) {
                    Text(key)
                        .font(.title3)
                        .fontWeight(.semibold)
                    if let value = menuItems[key] {
                        showFoodAvailability(availability: value[0])
                        AllergensView(allergens: value)

                    }
                }
                .padding(.leading)
                    
                }
                
            }
            
    }
}

struct showFoodAvailability: View {
    @State var availability: String
    var body: some View {
        if availability == "In Stock" {
            Text(availability)
                .fontWeight(.semibold)
                .foregroundStyle(Color("In Stock Color"))
        } else if availability == "Limited Availability" {
            Text(availability)
                .fontWeight(.semibold)
                .foregroundStyle(Color("Limited Availability Color"))
        } else if availability == "Out of Stock" {
            Text(availability)
                .fontWeight(.semibold)
                .foregroundStyle(.red)
        }
    }
}

struct AllergensView: View {
    @State var allergens: [String]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(1..<allergens.count) { index in
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("Allergens Background Color"))
                                .frame(width: 40, height: 40)
                            Text(allergens[index])
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
    }
}


