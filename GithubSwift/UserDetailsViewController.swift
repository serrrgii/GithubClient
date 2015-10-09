//
//  UserDetailsViewController.swift
//  GithubSwift
//
//  Created by Sergi Borras on 04/10/15.
//  Copyright © 2015 Sergi Borras. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAvatarUrl: UILabel!
    
    private var userViewModel: UserViewModel?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil,
            bundle: nibBundleOrNil)
    }
    
    convenience init(userViewModel: UserViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.userViewModel = userViewModel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let theViewModel = userViewModel {
            labelLogin.text = theViewModel.loginText
            labelName.text = theViewModel.nameText
            labelAvatarUrl.text = theViewModel.avatarURLText
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done,
            target: self,
            action: "done:")
    }
    func done(sender: UIBarButtonItem)
    {
        self.dismissViewControllerAnimated(true,
            completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
