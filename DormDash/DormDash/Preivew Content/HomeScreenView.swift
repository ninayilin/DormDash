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
                .scaledToFill()
                .ignoresSafeArea()
                

            VStack {
                Spacer()

                VStack(spacing: 20) { // Adds spacing between elements

                    // Email Input Field
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle()) // Adds a border
                        .keyboardType(.emailAddress) // Email-friendly keyboard
                        .autocapitalization(.none) // Prevents auto-capitalization
                        .padding()
                        .background(Color.white.opacity(0.8)) // Light background for visibility
                        .cornerRadius(10)
                        .padding(.horizontal, 40)

                    // Password Input Field
                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)

                    // Login Button
                    Button(action: {
                        print("Logging in with Email: \(email) and Password: \(password)")
                    }) {
                        Text("Login")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }

                    // Done Button
                    Button(action: {
                        print("Done button pressed")
                    }) {
                        Text("Done")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                }
                .padding(.bottom, 100) // Moves content slightly higher from the bottom edge
            }
        }
    }
}

#Preview {
    ContentView()
}
