//
//  SignInViewController.swift
//  MushroomSpot
//
//  Created by Apple on 14/04/25.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    
    private let viewModel = LoginVM()

    override func viewDidLoad() {
          super.viewDidLoad()
          errorLabel.text = ""

          viewModel.onLoginSuccess = {
              DispatchQueue.main.async {
                  self.errorLabel.text = ""
                  print("✅ Login success — pushing to HomeViewController")

                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  if let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                      self.navigationController?.pushViewController(homeVC, animated: true)
                  }
              }
          }

          viewModel.onLoginFailure = { message in
              DispatchQueue.main.async {
                  self.errorLabel.text = message
              }
          }
      }

  

    @IBAction func loginTapped(_ sender: Any) {
        
        viewModel.email = emailField.text ?? ""
               viewModel.password = passwordField.text ?? ""
               viewModel.login()
    }
    
    
}
