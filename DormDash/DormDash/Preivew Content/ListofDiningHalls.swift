import SwiftUI

struct DiningHallsView: View {
    let diningHalls = [
        "D2", "Turner Place", "West End", "Owens", "DXpress",
        "Au Bon Pain", "Burger '37", "Deet’s Place", "Squires Food Court"
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(diningHalls, id: \.self) { hall in
                        NavigationLink(destination: DiningView(diningHall: hall)) { // Correct destination
                            Text(hall)
                                .frame(maxWidth: .infinity, minHeight: 80)
                                .background(Color.orange.opacity(0.8))
                                .foregroundColor(.white)
                                .font(.headline)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Select Dining Hall")
        }
    }
}

struct DiningView: View {
    let diningHall: String

    var body: some View {
        Text("Menu for \(diningHall)")
            .font(.largeTitle)
            .padding()
    }
}

struct DiningHallsView_Previews: PreviewProvider {
    static var previews: some View {
        DiningHallsView()
    }
}

