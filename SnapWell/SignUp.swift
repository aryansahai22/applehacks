import SwiftUI

struct SignUp: View {
    var body: some View {
        VStack {
            Spacer()

            Text("Sign Up")
                .font(.largeTitle)
                .padding()

            TextField("First Name", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Email", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

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

            Spacer()
        }
        .background(Color.softGray)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
