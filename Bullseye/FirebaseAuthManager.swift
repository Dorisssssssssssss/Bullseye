//
//  FirebaseAuthManager.swift
//  Bullseye
//
//  Created by XIN on 9/5/25.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import Combine

class FirebaseAuthManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var currentUser: User?
    @Published var errorMessage = ""
    @Published var successMessage = ""
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUser = user
                self?.isLoggedIn = user != nil
                print("Verification Status Change: isLoggedIn = \(self?.isLoggedIn ?? false)")
                if let user = user {
                    print("Current User: \(user.email ?? "Unknown email"), UID: \(user.uid)")
                } else {
                    print("👤 No registerd user")
                }
            }
        }
    }
    
    deinit {
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    // Register new user
    func signUp(email: String, password: String) {
        clearMessages()
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "email and password cannot be empty"
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = "password need 6+ letters"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = self?.getErrorMessage(from: error) ?? "register failed"
                } else if let user = result?.user {
                    self?.successMessage = "register success！"
                    print("register failed，UID: \(user.uid)")
                    print("user email: \(user.email ?? "unknown")")
                }
            }
        }
    }
    
    func signIn(email: String, password: String) {
        clearMessages()
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "email and password cannot be empty"
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = self?.getErrorMessage(from: error) ?? "register failed"
                } else if let user = result?.user {
                    self?.successMessage = "register success！"
                    print("register success，UID: \(user.uid)")
                    print("user email: \(user.email ?? "unknown")")
                }
            }
        }
    }
    
    // logout
    func signOut() {
        do {
            try Auth.auth().signOut()
            successMessage = "Logged Out"
            print("User loggedout")
        } catch {
            errorMessage = "log out failed"
        }
    }
    
    func clearMessages() {
        errorMessage = ""
        successMessage = ""
    }
    
    private func getErrorMessage(from error: Error) -> String {
        if let authError = error as? AuthErrorCode {
            switch authError.code {
            case .emailAlreadyInUse:
                return "This email have already been used"
            case .invalidEmail:
                return "Email format incorrect"
            case .userNotFound:
                return "user not found"
            case .wrongPassword:
                return "wrong password"
            case .tooManyRequests:
                return "too many requests"
            case .networkError:
                return "network error"
            default:
                return "Authorization Failed：\(error.localizedDescription)"
            }
        }
        return "Unknown error：\(error.localizedDescription)"
    }
}
