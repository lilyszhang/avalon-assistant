//
//  ViewController.swift
//  Avalon Assistant
//
//  Created by Meg on 2/23/18.
//  Copyright © 2018 meggrasse. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    var nameField : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameLabel = UILabel()
        nameLabel.text = "Name?"
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameField = UITextField()
        nameField.borderStyle = .roundedRect
        nameField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameField)
        
        let joinButton = UIButton()
        joinButton.setTitle("Join", for: .normal)
        joinButton.backgroundColor = .green
        joinButton.addTarget(self, action: #selector(sendNameButton(_:)), for: .touchUpInside)
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(joinButton)
        
        let constraints = [
            nameField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            nameField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            nameField.bottomAnchor.constraint(equalTo: view.centerYAnchor),
//            nameField.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: nameField.topAnchor, constant: -20),

            joinButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            joinButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            joinButton.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func sendNameButton(_ sender: Any) {
        if let text = nameField.text {
            connectToServer(name: text)
        }
    }
    
    func connectToServer(name : String) {
        do {
            let uuid = UUID().uuidString
            
            let json = [
                "name" : name,
                "id" : uuid
            ] 
            
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let url = URL(string: kServerURL + "/join")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("\(String(describing: error))")
                    return
                } else if let data = data {
                    do {
                        let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
                        if let result = result {
                            DispatchQueue.main.async {
                                let nextVC = StartGameViewController()
                                nextVC.numPlayers = result["player_count"] as! Int?
                                nextVC.id = uuid
                                self.present(nextVC, animated: true, completion: nil)
                            }
                        }
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

