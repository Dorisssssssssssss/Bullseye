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
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authManager.isLoggedIn {
                    ContentView()
                        .environmentObject(authManager)
                        .onAppear {
                            print("📱 ShowContentView - Already Login")
                        }
                } else {
                    AuthView()
                        .environmentObject(authManager)
                        .onAppear {
                            print("📱 ShowAuthView - Haven't Login")
                        }
                }
            }
            .onAppear {
                print("🚀 Launch App，Current Login Status: \(authManager.isLoggedIn)")
            }
        }
    }
}
