//
//  DormPage.swift
//  DormDash
//
//  Created by Aryan Palit on 2/1/25.
//

import SwiftUI

import SwiftUI

struct DormInputView: View {
    @State private var dormName: String = ""
    @State private var roomNumber: String = ""
    
    @State private var showDormNamePrompt = false
    @State private var showRoomNumberPrompt = false
    @State private var showConfirmationAlert = false

    var body: some View {
        VStack(spacing: 20) {
            // Button to input Dorm Name
            Button(action: {
                showDormNamePrompt.toggle()
            }) {
                Text("Enter Dorm Name")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 250)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showDormNamePrompt) {
                InputPromptView(title: "Dorm Name", placeholder: "Enter your VT dorm name", inputText: $dormName)
            }
            
            // Button to input Room Number
            Button(action: {
                showRoomNumberPrompt.toggle()
            }) {
                Text("Enter Room Number")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 250)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showRoomNumberPrompt) {
                InputPromptView(title: "Room Number", placeholder: "Enter your room number", inputText: $roomNumber)
            }
            
            // Confirmation Button to show entered data
            if !dormName.isEmpty && !roomNumber.isEmpty {
                Button(action: {
                    showConfirmationAlert.toggle()
                }) {
                    Text("Confirm Details")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showConfirmationAlert) {
                    Alert(title: Text("Dorm Info"),
                          message: Text("You live in \(dormName), Room \(roomNumber)."),
                          dismissButton: .default(Text("OK")))
                }
            }
        }
        .padding()
    }
}

struct InputPromptView: View {
    let title: String
    let placeholder: String
    @Binding var inputText: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField(placeholder, text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Save") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                
                Spacer()
            }
            .navigationTitle(title)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .padding()
        }
    }
}

struct DormInputView_Previews: PreviewProvider {
    static var previews: some View {
        DormInputView()
    }
}
