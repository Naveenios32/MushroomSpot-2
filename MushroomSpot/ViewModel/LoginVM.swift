//
//  LoginViewModel.swift
//  MushroomSpot
//
//  Created by Apple on 14/04/25.
//

import Foundation

class LoginVM{
    var email: String = ""
    var password: String = ""

    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?

    func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }

    func isValidPassword(_ password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }

    func login() {
        guard isValidEmail(email) else {
            onLoginFailure?("❌ Invalid email format")
            return
        }

        guard isValidPassword(password) else {
            onLoginFailure?("❌ Password must have 8+ chars, 1 upper, 1 lower, 1 number, 1 special char")
            return
        }

        // ✅ No API call — just validation success
        print("✅ Validation passed — navigating to home")
        onLoginSuccess?()
    }
}
