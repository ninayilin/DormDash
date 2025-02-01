//
//  DormPage.swift
//  DormDash
//
//  Created by Aryan Palit on 2/1/25.
//

import SwiftUI

import SwiftUI

struct ApartmentSelectorView: View {
    @State private var showApartmentPicker = false
    @State private var showRoomPicker = false
    @State private var selectedApartment: String?
    @State private var selectedRoom: Int?
    @State private var showConfirmationAlert = false
    
    let apartments = ["Hoge Hall", "Paz Hall", "Was Hall"]
    let roomNumbers = [1, 2, 3, 4, 5]
    
    var body: some View {
        VStack {
            Button(action: {
                showApartmentPicker.toggle()
            }) {
                Text("Select Apartment & Room")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 250)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showApartmentPicker) {
                ApartmentPickerView(apartments: apartments) { apartment in
                    selectedApartment = apartment
                    showRoomPicker = true
                }
            }
            .sheet(isPresented: $showRoomPicker) {
                if let apartment = selectedApartment {
                    RoomPickerView(roomNumbers: roomNumbers, apartment: apartment) { room in
                        selectedRoom = room
                        showConfirmationAlert = true
                    }
                }
            }
            .alert(isPresented: $showConfirmationAlert) {
                Alert(title: Text("Selection Confirmed"),
                      message: Text("You selected \(selectedApartment ?? "") Room \(selectedRoom ?? 0)."),
                      dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
}

struct ApartmentPickerView: View {
    let apartments: [String]
    var onApartmentSelected: (String) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List(apartments, id: \.self) { apartment in
                Button(action: {
                    onApartmentSelected(apartment)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(apartment)
                }
            }
            .navigationTitle("Select Apartment")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct RoomPickerView: View {
    let roomNumbers: [Int]
    let apartment: String
    var onRoomSelected: (Int) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List(roomNumbers, id: \.self) { room in
                Button(action: {
                    onRoomSelected(room)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Room \(room)")
                }
            }
            .navigationTitle("Select Room in \(apartment)")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct ApartmentSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ApartmentSelectorView()
    }
}
