import SwiftUI

struct DeliveryInfoView: View {
    let dorms = [
        "Ambler Johnston", "Peddrew-Yates", "O'Shaughnessy", "Slusher",
        "New Hall West", "CoChrane", "Miles", "Lee", "Eggleston"
    ]
    
    @State private var selectedDorm: String? = nil
    @State private var cart: [String] = ["Burger", "Pizza", "Sushi"] // Sample items
    @State private var orderConfirmed = false

    var body: some View {
        ZStack {
            // Background Image
            Image("background2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // Content
            VStack(spacing: 20) {
                Text("Confirm Information")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white) // Adjust text color for visibility
                
                // Dorm Name Input
                
                
                
                // Display Cart Items
                VStack(alignment: .leading, spacing: 10) {
                    Text("Your Order")
                        .font(.headline)
                        .foregroundColor(.white) // Adjust text color for visibility
                    ForEach(cart, id: \.self) { item in
                        Text("• \(item)")
                            .foregroundColor(.white) // Adjust text color for visibility
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
                .shadow(radius: 2)
                .padding(.horizontal)
                
                // Confirm Order Button
                Button(action: {
                    if selectedDorm != nil {
                        orderConfirmed = true
                    }
                }) {
                    Text("Confirm Order")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedDorm != nil ? Color.green : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(selectedDorm == nil) // Disable if no dorm selected
                
                Spacer()
            }
            .padding(.top, 20)
            .alert(isPresented: $orderConfirmed) {
                Alert(
                    title: Text("Order Confirmed!"),
                    message: Text("Your food will be delivered to \(selectedDorm ?? "") soon."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct DeliveryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryInfoView()
    }
}

