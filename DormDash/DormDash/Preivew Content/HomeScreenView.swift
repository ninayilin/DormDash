//
//  HomeScreenView.swift
//  DormDash
//
//  Created by Nina Yang on 2/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false // Tracks login status

    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("background1")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()

                VStack(spacing: 10) {
                    // Email Input Field
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)

                    // Password Input Field
                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)

                    // Login Button (Triggers Navigation)
                    Button(action: {
                        print("Logging in with Email: \(email) and Password: \(password)")
                        isLoggedIn = true // Trigger navigation
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
                    .padding(.top, 150)
                    .padding(.bottom, 50)

                    // Hidden NavigationLink that activates when isLoggedIn = true
                    NavigationLink(destination: DiningHallsView(), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
