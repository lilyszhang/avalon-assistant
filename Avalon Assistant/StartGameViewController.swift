//
//  StartGameViewController.swift
//  Avalon Assistant
//
//  Created by Meg on 2/23/18.
//  Copyright © 2018 meggrasse. All rights reserved.
//

import UIKit

class StartGameViewController: UIViewController {
    
    var numPlayers : Int?
    var id : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoLabel = UILabel()
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)
        
        let startGameButton = UIButton()
        startGameButton.setTitle("START GAME", for: .normal)
        startGameButton.backgroundColor = .green
        startGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startGameButton)
        
        let constraints = [
            infoLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            infoLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            startGameButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            startGameButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            startGameButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        if let numPlayers = numPlayers {
            infoLabel.text = "\(numPlayers) players have joined"
            infoLabel.sizeToFit()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func startGame() {
        let url = URL(string: kServerURL + "/start")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print("\(String(describing: error))")
                return
            } else if let data = data {
                print(data)
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject]
                    if let result = result {
                        
                        for player in result {
                            if let playerId = player["id"] as? String, let playerRole = player["role"] as? Int {
                                if (playerId == self.id) {
                                    
                                    DispatchQueue.main.async {
                                        let nextVC = RoleViewController()
                                        
                                        // TODO: refactor
                                        switch playerRole {
                                        case 1:
                                            nextVC.role = "Loyal Servant of Arthur"
                                        case 2:
                                            nextVC.role = "Minion of Mordred"
                                        case 3:
                                            nextVC.role = "Merlin"
                                        case 4:
                                            nextVC.role = "Assasin"
                                        default:
                                            print("rip")
                                        }
                                    
                                        self.present(nextVC, animated: true, completion: nil)
                                    }
                                }
                            }
                        }

                    }
                    print("Result -> \(String(describing: result))")
                } catch {
                    print("Error -> \(error)")
                }
            }
        }
        task.resume()
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
