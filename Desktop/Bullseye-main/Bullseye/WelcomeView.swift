//
//  WelcomeView.swift
//  Bullseye
//
//  Created by XIN on 9/5/25.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var showAuth: Bool
    @EnvironmentObject var authManager: FirebaseAuthManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("🎯 Bullseye")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                            .padding(.top,25)
                        
                        Text("Welcome to Bullseye!")
                            .font(.title2)
                            .foregroundColor(.yellow)
                            .shadow(color: .black, radius: 2, x: 1, y: 1)
                        
                        Text("The ultimate precision game")
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                    }
                    
                    VStack(spacing: 15) {
                        Button(action: {
                            showAuth = true
                        }) {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.2, green: 0.6, blue: 0.9)) // 亮蓝色
                                .cornerRadius(10)
                                .shadow(color: .black, radius: 3, x: 2, y: 2)
                        }
                        
                        Button(action: {
                            showAuth = true
                        }) {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.6, green: 0.3, blue: 0.8)) // 紫罗兰色
                                .cornerRadius(10)
                                .shadow(color: .black, radius: 3, x: 2, y: 2)
                        }
                        
                        Button(action: {
                            print("Guest mode selected")
                        }) {
                            Text("Play as Guest")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.9, green: 0.4, blue: 0.4)) // 珊瑚红
                                .cornerRadius(10)
                                .shadow(color: .black, radius: 3, x: 2, y: 2)
                        }
                    }
                    .padding(.horizontal, 60)
                    
                    Spacer()
                }
            }
            .navigationTitle("Welcome")
            .navigationBarHidden(true)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(showAuth: .constant(false))
            .previewDevice("iPhone 14 Pro")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
