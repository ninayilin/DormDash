//
//  Menu.swift
//  DormDash
//
//  Created by Gautam Soni on 2/1/25.
//

import SwiftUI

struct MenuView: View {
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
        NavigationView {
            VStack {
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
            .navigationTitle("Menu")
            .sheet(isPresented: $showCart) {
                CartView(cart: cart)
            }
        }
    }
}

// Cart View (Displays selected items)
struct CartView: View {
    var cart: [String]
    
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

                Button("Close") {
                    // Dismiss the cart (handled by SwiftUI)
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
        MenuView()
    }
}

