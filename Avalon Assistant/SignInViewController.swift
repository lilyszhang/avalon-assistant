//
//  ViewController.swift
//  Avalon Assistant
//
//  Created by Meg on 2/23/18.
//  Copyright © 2018 meggrasse. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendNameButton(_ sender: Any) {
        if text = nameField.text {
            connectToServer(name: text)
        }
    }
    
    func connectToServer(name : String) {
        do {
            
            let json = [
                "name" : name
            ]
            
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let url = URL(string: "http://10.105.106.145:5000/join")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("\(String(describing: error))")
                    return
                } else if let data = data {
                    do {
                        let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
                        print("Result -> \(String(describing: result))")
                    } catch {
                        print("Error -> \(error)")
                    }
                }
            }
            task.resume()
        } catch {
            print(error)
        }
    }

}

