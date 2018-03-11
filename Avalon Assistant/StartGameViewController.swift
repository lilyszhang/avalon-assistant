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
    
    var switches : Array<UISwitch>?
    
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
        
        let percivalSwitchLabel = UILabel()
        percivalSwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        percivalSwitchLabel.text = "Percival"
        percivalSwitchLabel.sizeToFit()
        view.addSubview(percivalSwitchLabel)
        
        let percivalSwitch = UISwitch()
        percivalSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(percivalSwitch)
        
        let mordredSwitchLabel = UILabel()
        mordredSwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        mordredSwitchLabel.text = "Mordred"
        mordredSwitchLabel.sizeToFit()
        view.addSubview(mordredSwitchLabel)
        
        let mordredSwitch = UISwitch()
        mordredSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mordredSwitch)
        
        let morganaSwitchLabel = UILabel()
        morganaSwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        morganaSwitchLabel.text = "Morgana"
        morganaSwitchLabel.sizeToFit()
        view.addSubview(morganaSwitchLabel)
        
        let morganaSwitch = UISwitch()
        morganaSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(morganaSwitch)

        let oberonSwitchLabel = UILabel()
        oberonSwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        oberonSwitchLabel.text = "Oberon"
        oberonSwitchLabel.sizeToFit()
        view.addSubview(oberonSwitchLabel)
        
        let oberonSwitch = UISwitch()
        oberonSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(oberonSwitch)
        
        switches = [percivalSwitch, mordredSwitch, morganaSwitch, oberonSwitch]
        
        let constraints = [
            infoLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            infoLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            startGameButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            startGameButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            startGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            percivalSwitchLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 40),
            percivalSwitchLabel.centerYAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 100),

            percivalSwitch.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -40),
            percivalSwitch.centerYAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 100),
            
            mordredSwitchLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 40),
            mordredSwitchLabel.centerYAnchor.constraint(equalTo: percivalSwitchLabel.bottomAnchor, constant: 50),
            
            mordredSwitch.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -40),
            mordredSwitch.centerYAnchor.constraint(equalTo: percivalSwitchLabel.bottomAnchor, constant: 50),
            
            morganaSwitchLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 40),
            morganaSwitchLabel.centerYAnchor.constraint(equalTo: mordredSwitchLabel.bottomAnchor, constant: 50),
            
            morganaSwitch.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -40),
            morganaSwitch.centerYAnchor.constraint(equalTo: mordredSwitchLabel.bottomAnchor, constant: 50),
            
            oberonSwitchLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 40),
            oberonSwitchLabel.centerYAnchor.constraint(equalTo: morganaSwitchLabel.bottomAnchor, constant: 50),
            
            oberonSwitch.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -40),
            oberonSwitch.centerYAnchor.constraint(equalTo: morganaSwitchLabel.bottomAnchor, constant: 50),
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
        do {
            
            if let switches = switches {
            
                // TODO: refactor
                let json = [
                    Player.percival.name.lowercased() : switches[0].isOn,
                    Player.mordred.name.lowercased() : switches[1].isOn,
                    Player.morgana.name.lowercased() : switches[2].isOn,
                    Player.oberon.name.lowercased() : switches[3].isOn
                ]
            
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let url = URL(string: kServerURL + "/start")
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                                                if let player = Player(rawValue: playerRole) {
                                                    nextVC.role = player
                                                    nextVC.playersInfo = result as? Array<Dictionary<String, Any>>
                                                    self.present(nextVC, animated: true, completion: nil)
                                                } else  {
                                                    print("error")
                                                }

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
        } catch {
            print(error)
        }
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
