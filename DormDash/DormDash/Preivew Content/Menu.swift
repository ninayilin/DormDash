//
//  Menu.swift
//  DormDash
//
//  Created by Arihita Dirghangi on 2/1/25.
//

// Menu.swift
import SwiftUI

struct MenuView: View {
    let diningHall: String // Pass the dining hall name
    let menuItems = [
        ("Burger", "$5.99"),
        ("Pizza", "$8.99"),
        ("Salad", "$4.99"),
        ("Sushi", "$12.99"),
        ("Pasta", "$7.99")
    ]
    
    @State private var cart: [String] = [] // Store added items
    @State private var showCart = false   // Toggle cart view

    var body: some View {
        VStack {
            Text("Menu for \(diningHall)") // Display dining hall name
                .font(.largeTitle)
                .bold()
                .padding()

            List(menuItems, id: \.0) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.0)
                            .font(.headline)
                        Text(item.1)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {
                        cart.append(item.0) // Add to cart
                    }) {
                        Text("Add")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
            }

            // Cart Button
            Button(action: {
                showCart.toggle()
            }) {
                Text("View Cart (\(cart.count))")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .navigationTitle(diningHall) // Use the dining hall name in the title
        .sheet(isPresented: $showCart) {
            CartView(cart: cart) // Pass the cart to CartView
        }
    }
}

// Cart View (Displays selected items)
struct CartView: View {
    var cart: [String]
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToDeliveryInfoPage = false  // Navigation flag

    var body: some View {
        NavigationView {
            VStack {
                List(cart, id: \.self) { item in
                    Text(item)
                }
                .navigationTitle("Your Cart")
                
                Text("Total Items: \(cart.count)")
                    .font(.headline)
                    .padding()

                Button("Order") {
                    // Set navigation flag to true to go to DeliveryInfoView
                    navigateToDeliveryInfoPage = true
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                NavigationLink(
                    destination: DeliveryInfoView(),  // Navigate to DeliveryInfoView
                    isActive: $navigateToDeliveryInfoPage
                ) {
                    EmptyView()  // Invisible link to trigger navigation
                }
                
                Button("Close") {
                    // Dismiss the cart (handled by SwiftUI)
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(diningHall: "D2") // Example preview
    }
}
