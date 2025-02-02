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
            ZStack {
                // Background Image
                Image("background2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Text("Select Dining Hall")
                        .font(.largeTitle)
                        .font(.custom("Verdana", size:14))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(diningHalls, id: \.self) { hall in
                            NavigationLink(destination: MenuView(diningHall: hall)) {
                                Text(hall)
                                    .font(.custom("Verdana", size:14))
                                    .frame(maxWidth: .infinity, minHeight: 80)
                                    .background(Color.orange)
                                    .opacity(0.96)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .cornerRadius(14)
                                    .shadow(radius: 3)
                            }
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 80)
            }
        }
    }
}

struct DiningHallsView_Previews: PreviewProvider {
    static var previews: some View {
        DiningHallsView()
    }
}
