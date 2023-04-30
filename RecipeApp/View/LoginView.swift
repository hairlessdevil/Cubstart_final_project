import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            // Add your main app view here
            //Text("Welcome to FoodiZone!")
        } else {
            VStack {
                Spacer()
                Image("foodizone_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("Welcome to FoodiZone")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top, 50)
                Text("Sign in to continue")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    Button(action: {
                        // Check login credentials here
                        if email == "user@example.com" && password == "password" {
                            isLoggedIn = true
                            
                        }
                    }) {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.green)
                            .cornerRadius(15.0)
                    }
                }.padding(.horizontal)
                Spacer()
                Text("Don't have an account? Sign up")
                    .foregroundColor(.green)
                    .padding(.bottom, 20)
            }
        }
    }
    
    init() {
        // Check if user is already logged in
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            isLoggedIn = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
