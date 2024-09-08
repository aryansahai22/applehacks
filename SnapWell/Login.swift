import SwiftUI

struct Login: View {
    var body: some View {
        VStack {
            Spacer()

            Text("Login")
                .font(.largeTitle)
                .padding()

            TextField("Email", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                // Login action
            }) {
                Text("Login")
                    .padding()
                    .background(Color.softAqua)
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

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
