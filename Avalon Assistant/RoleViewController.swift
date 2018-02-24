//
//  RoleViewController.swift
//  Avalon Assistant
//
//  Created by Meg on 2/23/18.
//  Copyright © 2018 meggrasse. All rights reserved.
//

import UIKit

class RoleViewController: UIViewController {
    
    var role : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let roleLabel = UILabel()
        roleLabel.text = role
        roleLabel.textAlignment = .center
        roleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(roleLabel)
        
        let constraints = [
            roleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            roleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            roleLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
