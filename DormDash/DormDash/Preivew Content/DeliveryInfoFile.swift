//
//  DeliveryInfoFile.swift
//  DormDash
//
//  Created by Arihita Dirghangi on 2/1/25.
//

import SwiftUI

struct DeliveryInfoView: View {
    let dorms = [
        "Ambler Johnston", "Peddrew-Yates", "O'Shaughnessy", "Slusher",
        "New Hall West", "CoChrane", "Miles", "Lee", "Eggleston"
    ]
    
    @State private var selectedDorm: String? = nil
    @State private var cart: [String] = ["Burger", "Pizza", "Sushi"] // Sample items
    @State private var orderConfirmed = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Select Your Dorm")
                    .font(.title2)
                    .bold()
                
                // Dorm Selection Dropdown
                Menu {
                    ForEach(dorms, id: \.self) { dorm in
                        Button(action: { selectedDorm = dorm }) {
                            Text(dorm)
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedDorm ?? "Choose a Dorm")
                            .foregroundColor(selectedDorm == nil ? .gray : .black)
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)

                // Display Cart Items
                VStack(alignment: .leading, spacing: 10) {
                    Text("Your Order")
                        .font(.headline)
                    ForEach(cart, id: \.self) { item in
                        Text("• \(item)")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                .padding(.horizontal)
                
                // Confirm Order Button
                Button(action: {
                    if selectedDorm != nil {
                        orderConfirmed = true
                    }
                }) {
                    Text("Confirm Order")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedDorm != nil ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(selectedDorm == nil) // Disable if no dorm selected
                
                Spacer()
            }
            .padding(.top, 20)
            .navigationTitle("Delivery Info")
            .alert(isPresented: $orderConfirmed) {
                Alert(
                    title: Text("Order Confirmed!"),
                    message: Text("Your food will be delivered to \(selectedDorm ?? "") soon."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct DeliveryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryInfoView()
    }
}

