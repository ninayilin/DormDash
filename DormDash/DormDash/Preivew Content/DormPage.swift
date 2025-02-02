import SwiftUI

struct ZoneSelectorView: View {
    @State private var expandedZone: String? = nil
    @State private var selectedDorm: String = ""
    @State private var roomNumber: String = ""
    @State private var showRoomPrompt = false
    @State private var showConfirmationAlert = false
    @State private var navigateToDiningHall = false // State to control navigation

    let zones = [
        "Owens and Hokie Grill": ["Newman", "Johnston", "Miles", "Whitehurst", "Vawter"],
        "D2 and Owens": ["Hoge", "Oshag", "Prichard", "Pedrew", "New Residence Hall", "Payne", "Campbell"],
        "West End": ["AJ", "Cochraine", "Harper", "New Hall West", "Slusher"],
        "Hokie Grill": ["Eggleston", "CID", "GLC"],
        "Turners or Perry Place": ["Pearson", "Hillcrest"]
    ]
    
    var body: some View {
        NavigationStack { // Embed in NavigationStack
            ZStack {
                // Background Image
                Image("background2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Your Dorm is Near: ") // Title at the top
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .font(.custom("Verdana", size:18))
                    
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
            .navigationDestination(isPresented: $navigateToDiningHall) { // Navigation destination
                ListOfDiningHall()
            }
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
            .background(Color.orange)
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
                    .background(Color.white.opacity(0.8))
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
                    navigateToDiningHall = true // Trigger navigation
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
                .background(Color.orange)
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

// MARK: - List of Dining Hall View
struct ListOfDiningHall: View {
    var body: some View {
        Text("List of Dining Halls")
            .font(.title)
            .padding()
    }
}

// MARK: - Preview
struct ZoneSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneSelectorView()
    }
}

