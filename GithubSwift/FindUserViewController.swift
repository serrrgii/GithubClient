//
//  ViewController.swift
//  GithubSwift
//
//  Created by Sergi Borras on 04/10/15.
//  Copyright © 2015 Sergi Borras. All rights reserved.
//

import UIKit

class FindUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldLogin: UITextField!
    var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textFieldLogin.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func findUserWithLogin(login: String) {
       userViewModel.findUserWithLogin(login) { result in
        switch result {
        case .Success(let viewModel): self.presentUserDetailsViewController(viewModel)
        case .Error(let error): print("Error \(error)")
            }
        }
    }
    
    func presentUserDetailsViewController(viewModel: UserViewModel) {
        let controller = UserDetailsViewController(userViewModel:  viewModel)
        let navigationController = UINavigationController(rootViewController: controller)
        self.presentViewController(navigationController,
            animated: true
            , completion: nil)
        
    }
    // MARK: - UITextField delegate method
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let theText = textField.text {
            findUserWithLogin(theText)
        }
        return true
    }
}

