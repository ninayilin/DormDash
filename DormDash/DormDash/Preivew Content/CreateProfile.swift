//
//  CreateProfile.swift
//  DormDash
//
//  Created by Arihita Dirghangi on 2/1/25.
//

import SwiftUI

struct CreateProfileView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var dorm: String = ""
    @State private var phone: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Info")) {
                    TextField("Full Name", text: $name)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                }

                Section(header: Text("Dorm Information")) {
                    TextField("Dorm Name", text: $dorm)
                }

                Button(action: saveProfile) {
                    Text("Create Profile")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Create Profile")
        }
    }
    
    func saveProfile() {
        // Here, you can save the profile info locally or send it to a backend
        print("Profile Created: \(name), \(email), \(dorm), \(phone)")
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView()
    }
}
