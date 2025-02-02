import SwiftUI

struct ListofDiningHalls: View {
    var diningHall: String

    var body: some View {
        Text("Welcome to \(diningHall)")
            .font(.largeTitle)
            .padding()
    }
}

struct ZoneSelectorView: View {
    @State private var expandedZone: String? = nil
    @State private var selectedDorm: String = ""
    @State private var roomNumber: String = ""
    @State private var showConfirmationAlert = false
    @State private var navigationPath = NavigationPath() // ✅ Keep track of navigation

    let zones = [
        "Owens and Hokie Grill": ["Newman", "Johnston", "Miles", "Whitehurst", "Vawter"],
        "D2 and Owens": ["Hoge", "Oshag", "Prichard", "Pedrew", "New Residence Hall", "Payne", "Campbell"],
        "West End": ["AJ", "Cochraine", "Harper", "New Hall West", "Slusher"],
        "Hokie Grill": ["Eggleston", "CID", "GLC"],
        "Turners or Perry Place": ["Pearson", "Hillcrest"]
    ]

    var body: some View {
        NavigationStack(path: $navigationPath) {  // ✅ Use NavigationStack with navigationPath
            VStack(spacing: 20) {
                Text("Your Dorm is Near:")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)

                roomNumberInput
                zoneButtons
                Spacer()
            }
            .padding()
            .alert(isPresented: $showConfirmationAlert) {
                Alert(
                    title: Text("Selection Confirmed"),
                    message: Text("You selected \(selectedDorm), Room \(roomNumber)."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(for: String.self) { diningHall in  // ✅ Ensure it matches NavigationLink(value:)
                ListofDiningHalls(diningHall: diningHall)
            }
        }
    }

    private var roomNumberInput: some View {
        VStack {
            Text("Enter Your Room Number")
                .font(.headline)
            TextField("Room Number", text: $roomNumber)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
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
            NavigationLink(value: dorm) {  // ✅ Pass dorm name as navigation value
                Text(dorm)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 250, alignment: .leading)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(5)
            }
        }
    }
}

#Preview {
    ZoneSelectorView()
}

