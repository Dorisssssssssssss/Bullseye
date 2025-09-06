//
//  BullseyeApp.swift
//  Bullseye
//
//  Created by XIN on 9/4/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct BullseyeApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authManager = FirebaseAuthManager()
    @State private var showAuth = false  // 控制是否显示认证界面
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authManager.isLoggedIn {
                    ContentView()
                        .environmentObject(authManager)
                        .onAppear {
                            print("📱 ShowContentView - Already Login")
                        }
                } else if showAuth {
                    AuthView(showAuth: $showAuth)
                        .environmentObject(authManager)
                        .onAppear {
                            print("📱 ShowAuthView - Authentication")
                        }
                } else {
                    WelcomeView(showAuth: $showAuth)
                        .environmentObject(authManager)
                        .onAppear {
                            print("📱 ShowWelcomeView - Welcome Page")
                        }
                }
            }
            .onAppear {
                print("🚀 Launch App，Current Login Status: \(authManager.isLoggedIn)")
            }
        }
    }
}
