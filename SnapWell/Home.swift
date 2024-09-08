import SwiftUI

struct Home: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Ensure background extends to edges

            VStack {
                Spacer() // Push content down from the top

                Text("Welcome to SnapWell")
                    .font(.custom("Avenir", size: 24))
                    .foregroundColor(.white)
                    .padding(.bottom, 50)

                HStack {
                    Button(action: {
                        // Sign up action
                    }) {
                        Text("Sign Up")
                            .padding()
                            .background(Color.softBlue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()

                    Button(action: {
                        // Login action
                    }) {
                        Text("Login")
                            .padding()
                            .background(Color.softBlue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }

                Spacer() // Push content up from the bottom
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
