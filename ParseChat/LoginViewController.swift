//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Abraham De Alba on 10/22/18.
//  Copyright © 2018 Abraham De Alba. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController
{

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    @IBAction func LoginButt(_ sender: Any)
    {
        if (userName.text == "") || (passWord.text == "")
        {
            present(alertController, animated: true)
        }
        else {
            loginUser()
            
        }
    }
    
    @IBAction func SignupButt(_ sender: Any)
    {
        if (userName.text == "") || (passWord.text == "")
        {
            present(alertController, animated: true)
        }
        else {
            registerUser()
        }
    }

    
    let alertController = UIAlertController(title: "Error", message: "Both Fields are empty. \nPlease enter username and password", preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    { (action) in
        // handle cancel response here. Doing nothing will dismiss the view.
    }
    
    let OKAction = UIAlertAction(title: "OK", style: .default)
    { (action) in
        // handle response here.
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        alertController.addAction(OKAction)
    }
    
    func registerUser()
    {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = userName.text
        newUser.password = passWord.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    }
    
    func loginUser()
    {
        
        let username = userName.text ?? ""
        let password = passWord.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }

}
