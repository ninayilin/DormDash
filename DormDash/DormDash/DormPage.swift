//
//  DormPage.swift
//  DormDash
//
//  Created by Aryan Palit on 2/1/25.
//

import SwiftUI

struct ZoneSelectorView: View {
    @State private var expandedZone: String? = nil
    @State private var selectedDorm: String = ""
    @State private var roomNumber: String = ""
    
    @State private var showRoomPrompt = false
    @State private var showConfirmationAlert = false

    let zones = [
        "Zone 1": ["AJ", "Cochraine", "Harper", "New Hall West", "Slusher"],
        "Zone 2": ["Hoge", "Oshag", "Prichard", "Pedrew", "NHE", "Payne", "Campbell"],
        "Zone 3": ["Newman", "Johnston", "Miles", "Whitemore", "Vawter"],
        "Zone 4": ["Eggleston", "CID", "GLC"],
        "Zone 5": ["Pearson", "Hillcrest"]
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            // Zone Buttons with Drop-Down Dorms
            ForEach(Array(zones.keys.sorted()), id: \.self) { zone in
                VStack(alignment: .leading, spacing: 10) {
                    Button(action: {
                        withAnimation {
                            expandedZone = (expandedZone == zone) ? nil : zone
                        }
                    }) {
                        HStack {
                            Text(zone)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 250, alignment: .leading)
                            Spacer()
                            Image(systemName: expandedZone == zone ? "chevron.up" : "chevron.down")
                                .foregroundColor(.white)
                                .padding(.trailing)
                        }
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    
                    // Display dorms when a zone is expanded
                    if expandedZone == zone {
                        ForEach(zones[zone]!, id: \.self) { dorm in
                            Button(action: {
                                selectedDorm = dorm
                                showRoomPrompt = true
                            }) {
                                Text(dorm)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 250, alignment: .leading)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            // Display Message with Selection
            if !selectedDorm.isEmpty && !roomNumber.isEmpty {
                Text("You live in room \(roomNumber) in \(selectedDorm) Hall.")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom)
            }
        }
        .padding()
        .sheet(isPresented: $showRoomPrompt) {
            RoomInputView(dorm: selectedDorm, roomNumber: $roomNumber) {
                showConfirmationAlert = true
            }
        }
        .alert(isPresented: $showConfirmationAlert) {
            Alert(
                title: Text("Selection Confirmed"),
                message: Text("You selected \(selectedDorm), Room \(roomNumber)."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// MARK: - Room Input View
struct RoomInputView: View {
    let dorm: String
    @Binding var roomNumber: String
    var onRoomEntered: () -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Enter Room Number for \(dorm)")
                    .font(.headline)
                    .padding(.top)
                
                TextField("Room Number", text: $roomNumber)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Save") {
                    onRoomEntered()
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
                .padding()
                .frame(width: 200)
                .background(Color.green)
                .cornerRadius(10)
                
                Spacer()
            }
            .navigationTitle("Room Number")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .padding()
        }
    }
}

// MARK: - Preview
struct ZoneSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneSelectorView()
    }
}
