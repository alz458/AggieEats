//
//  ContentView.swift
//  AggieEats
//

import SwiftUI
import MapKit
import CodeScanner
import OrderedCollections

struct HomePage: View {
    let menu: [Menu] = Bundle.main.decode("Menu.json")
    
    @State var showScanner = false
    @State var navigateToOrderingPage = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Today's Location")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            ScanQrCodeButton(showScanner: $showScanner)
                        }
                        
                        ForEach(menu, id: \.self) { menuOption in
                            if menuOption.day == getTodayWeekDay() {
                                Text(menuOption.locationName)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                TruckLocationView(markerName: menuOption.locationName, coordinates: menuOption.coordinate)
                                TodaysMenuView(menuItems: menuOption.menu)
                            }
                        }
                    } //end of inner VStack
                    
                }
            }
            .sheet(isPresented: $showScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "ABCDE", completion: handleScan)
            }
            .navigationDestination(isPresented: $navigateToOrderingPage) {
                ConfirmOrderView()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
    }
    
    func getTodayWeekDay()-> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE"
           let weekDay = dateFormatter.string(from: Date())
           return weekDay
     }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
       showScanner = false
        switch result {
        case .success(let result):
            navigateToOrderingPage = true
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}


struct ScanQrCodeButton: View {
    @Binding var showScanner: Bool
    var body: some View {
        Button {
            showScanner = true
        } label: {
            Image(systemName: "camera")
                .imageScale(.large)
        }
    }
}

struct TruckLocationView: View {
    @State var markerName: String
    @State var coordinates: [Double]
    
    var body: some View {
        Map {
            Marker(markerName, coordinate: CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1]))
        }
        .frame(width: 380, height: 400)
        
        .padding(.bottom)
    }
}

//First thing I did
struct TodaysMenuView: View {
    @State var menuItems: OrderedDictionary<String, [String]>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("What's On The Menu?")
                .font(.title)
                .fontWeight(.bold)
            MenuOptionsView(menuItems: menuItems)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    HomePage()
}
