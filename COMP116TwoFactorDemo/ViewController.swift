//
//  ViewController.swift
//  COMP116TwoFactorDemo
//
//  Created by Alex King on 11/21/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var authenticationButton: UIButton!
    
    // Function is executed each time the Authenticate button is tapped
    @IBAction func touchedAuthenticate(_ sender: Any) {
        
        // Grab a local authentication context to begin the Touch ID process
        let context = LAContext()
        
        // Request fingerprint. If successful, move on and ask for second form of authentication
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                                 localizedReason: "Authentication is required",
                                 reply: { (status: Bool, evaluationError: Error?) -> Void in
                                    if status {
                                        DispatchQueue.main.async {
                                            self.requestPassword()
                                        }
                                    } else {
                                        DispatchQueue.main.async {
                                            print("Error received")
                                        }
                                    }
        })

    }
    
    // Sends pop-up notification to user and prompts for password
    func requestPassword() {
        
        let passwordAlert = UIAlertController(title:"COMP116 Two Factor Demo",
                                                message: "Please enter your password to proceed.",
                                                preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { (action) -> Void in
            let passwordTextField = passwordAlert.textFields![0] as UITextField
            if let text = passwordTextField.text {
                if text == "secret!" {
                    // Inside this context, sensitive information can be shared safely!
                    self.authenticationButton.setTitle("User successfully authenticated!", for: UIControlState.normal)
                } else {
                    // In this example, repeatedly request until correct
                    self.requestPassword()
                }
            }
        }
        doneAction.isEnabled = false
        
        passwordAlert.addTextField { (textField) -> Void in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main, using: { (notification) -> Void in
                doneAction.isEnabled = textField.text != ""
            })
        }
        passwordAlert.addAction(doneAction)
        
        self.present(passwordAlert, animated: true) {
            // No code necessary
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

