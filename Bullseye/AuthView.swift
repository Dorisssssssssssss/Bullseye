//
//  AuthView.swift
//  Bullseye
//
//  Created by XIN on 9/5/25.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @StateObject private var authManager = FirebaseAuthManager()
    @State private var isSignUpMode: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    let midnightBlue = Color(red: 0.0/255.0, green: 51/255.0, blue: 102/255.0)
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Text("🎯 Bullseye")
                            .modifier(LabelStyle())
                        
                        Text(isSignUpMode ? "Create new account" : "Welcome Back！")
                            .modifier(ValueStyle())
                        
                        if !isSignUpMode {
                            Text("No Account? Sign up!")
                                .foregroundColor(.white)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 25) {
                        // email
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .modifier(LabelStyle())
                            
                            TextField("Email", text: $email)
                                .textFieldStyle(CustomTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        
                        // password
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .modifier(LabelStyle())
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(CustomTextFieldStyle())
                        }
                        
                        // notification
                        if !authManager.errorMessage.isEmpty {
                            Text(authManager.errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        if !authManager.successMessage.isEmpty {
                            Text(authManager.successMessage)
                                .foregroundColor(.green)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        // operations
                        Button(action: {
                            if isSignUpMode {
                                authManager.signUp(email: email, password: password)
                            } else {
                                authManager.signIn(email: email, password: password)
                            }
                        }) {
                            Text(isSignUpMode ? "Sign Up" : "Sign In")
                                .modifier(ButtonLargeTextStyle())
                        }
                        .background(Image("Button"))
                        .modifier(ShadowStyle())
                        .disabled(email.isEmpty || password.isEmpty)
                        
                        // change button
                        VStack(spacing: 10) {
                            Button(action: {
                                isSignUpMode.toggle()
                                authManager.clearMessages()
                            }) {
                                Text(isSignUpMode ? "Already have an account? Sign In!" : "No account? Sign Up!")
                                    .modifier(ButtonSmallTextStyle())
                            }
                            
                            // signup notification
                            if !isSignUpMode {
                                Text("New to Bullseye? Create your account now!")
                                    .foregroundColor(.yellow)
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 30)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
            .navigationTitle(isSignUpMode ? "Sign Up" : "Sign In")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.white.opacity(0.5), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .environmentObject(authManager)
        .onAppear {
            print("AuthView Shown")
        }
    }
}

// TextField style
struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black, radius: 2, x: 1, y: 1)
    }
}

// word styling
struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(Font.custom("Arial Rounded MT Bold", size: 20))
            .shadow(color: .black, radius: 2, x: 1, y: 1)
    }
}

struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.yellow)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .shadow(color: .black, radius: 2, x: 1, y: 1)
    }
}

struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .frame(maxWidth: .infinity)
            .padding()
    }
}

struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(Font.custom("Arial Rounded MT Bold", size: 14))
            .underline()
            .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
    }
}

struct ShadowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black, radius: 3, x: 2, y: 2)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(FirebaseAuthManager())
            .previewDevice("iPhone 14 Pro").environmentObject(FirebaseAuthManager())
            .previewInterfaceOrientation(.landscapeLeft)
    
    }
}
