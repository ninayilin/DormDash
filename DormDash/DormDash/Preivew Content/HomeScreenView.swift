//
//  HomeScreenView.swift
//  DormDash
//
//  Created by Nina Yang on 2/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = "" // Stores the email input
    @State private var password: String = "" // Stores the password input

    var body: some View {
        ZStack {
            // Background Image
            Image("background1")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            
            VStack {
                Spacer()

                VStack(spacing: 20) { // Adds spacing between elements
                    
                    // Email Input Field
                    TextField("Email:", text: $email)
                        .font(.custom("Verdana", size:14))
                        .textFieldStyle(RoundedBorderTextFieldStyle()) // Adds a border
                        .keyboardType(.emailAddress) // Email-friendly keyboard
                        .autocapitalization(.none) // Prevents auto-capitalization
                        .padding()
                        .background(Color(red: 209/255, green: 111/255, blue: 96/255, opacity: 0.4)) // Equivalent to #D16F60 // Light background for visibility
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    
                    // Password Input Field
                    SecureField("Password:", text: $password)
                        .font(.custom("Verdana", size:14))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color(red: 209/255, green: 111/255, blue: 96/255, opacity: 0.4)) // Equivalent to #D16F60
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                    
                    // Login Button
                    Button(action: {
                        print("Logging in with Email: \(email) and Password: \(password)")
                    }) {
                        Text("Login")
                            .font(.custom("Verdana", size:18))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                    
                    Text("Don't have an account yet? Sign up here!")
                        .font(.custom("Verdana", size:14))
                        .underline()
                        .foregroundColor(Color.white)
                }
                .padding(.bottom, 115) // Moves content slightly higher from the bottom edge
            }
        }
    }
}

#Preview {
    ContentView()
}
