//
//  WeeklyMenuView.swift
//  AggieEats
//

import SwiftUI

struct WeeklyMenuView: View {
    let menu: [Menu] = Bundle.main.decode("Menu.json")
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Weekly Menu")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                ForEach(menu, id: \.self) { menuOption in
                    VStack(alignment: .leading) {
                        Text(menuOption.day)
                            .font(.title2)
                            .fontWeight(.bold)
                        MenuOptionsView(menuItems: menuOption.menu)
                    }
                    .padding(.bottom)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WeeklyMenuView()
}
