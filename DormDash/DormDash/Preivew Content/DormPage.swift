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
        "Upper Quad": ["Newman", "Johnston", "Miles", "Whitehurst", "Vawter"],
        "Lower Quad": ["Hoge", "Oshag", "Prichard", "Pedrew", "New Residence Hall", "Payne", "Campbell"],
        "West End": ["AJ", "Cochraine", "Harper", "New Hall West", "Slusher"],
        "Eas Side": ["Eggleston", "CID", "GLC"],
        "Off Campus adjacent": ["Pearson", "Hillcrest"]
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            zoneButtons
            Spacer()
            selectionMessage
            doneButton
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

    private var zoneButtons: some View {
        ForEach(Array(zones.keys.sorted()), id: \.self) { zone in
            VStack(alignment: .leading, spacing: 10) {
                zoneButton(for: zone)
                if expandedZone == zone {
                    dormButtons(for: zone)
                }
            }
        }
    }

    private func zoneButton(for zone: String) -> some View {
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
    }

    private func dormButtons(for zone: String) -> some View {
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

    private var selectionMessage: some View {
        Group {
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
    }

    private var doneButton: some View {
        Group {
            if !selectedDorm.isEmpty && !roomNumber.isEmpty {
                Button(action: {
                    print("Done button pressed for \(selectedDorm), Room \(roomNumber)")
                }) {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
            }
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
                
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
                .padding()
                .frame(width: 200)
                .background(Color.blue)
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
