import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            Spacer() // Add space at the top

            // Logo
            Image("snapwellogo")  // Make sure the name matches the asset name
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.clear)
                )

            // Welcome Text
            Text("SnapWell")
                .font(.custom("Avenir", size: 40))
                .foregroundColor(.white)
                .padding(.bottom, 20)
                .padding(.top, 20)

            // Sign Up and Login Buttons
            HStack(spacing: 20) {
                Button(action: {
                    // Sign up action
                }) {
                    Text("Sign Up")
                        .padding()
                        .frame(width: 120)  // Set width for consistent button size
                        .background(Color.softBlue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    // Login action
                }) {
                    Text("Login")
                        .padding()
                        .frame(width: 120)  // Set width for consistent button size
                        .background(Color.softBlue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 60)  // Adjust bottom padding for better spacing

            Spacer() // Add space at the bottom
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
