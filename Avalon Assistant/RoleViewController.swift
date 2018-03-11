//
//  RoleViewController.swift
//  Avalon Assistant
//
//  Created by Meg on 2/23/18.
//  Copyright © 2018 meggrasse. All rights reserved.
//

import UIKit

class RoleViewController: UIViewController {
    
    var role : Player? = nil
    var playersInfo : Array<Dictionary<String, Any>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let roleLabel = UILabel()
        roleLabel.text = role?.name
        roleLabel.textAlignment = .center
        roleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(roleLabel)
        
        let powerLabel = UILabel()
        powerLabel.numberOfLines = 0
        powerLabel.textAlignment = .center
        powerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(powerLabel)
        
        if let role = role {
            if let info = playersInfo {
                switch role {
                case .normalBad, .morgana, .mordred, .assassin:
                    var visibleInfo : [String] = []
                    for currPlayer in info {
                        let team = currPlayer["team"] as? Int
                        let role = currPlayer["role"] as? Int
                        if team == 2 && role != Player.oberon.rawValue {
                            let name = currPlayer["name"] as? String
                            if let name = name {
                                visibleInfo.append(name)
                            }
                        }
                    }
                    powerLabel.text = "Bad players: " + visibleInfo.joined(separator: ", ")
                case .merlin:
                    var visibleInfo : [String] = []
                    for currPlayer in info {
                        let team = currPlayer["team"] as? Int
                        let role = currPlayer["role"] as? Int
                        if team == 2 && role != Player.mordred.rawValue {
                            let name = currPlayer["name"] as? String
                            if let name = name {
                                visibleInfo.append(name)
                            }
                        }
                    }
                    powerLabel.text = "Bad players: " + visibleInfo.joined(separator: ", ")
                case .percival:
                    var visibleInfo : [String] = []
                    for currPlayer in info {
                        let role = currPlayer["role"] as? Int
                        if role == Player.merlin.rawValue {
                            let name = currPlayer["name"] as? String
                            if let name = name {
                                visibleInfo.append(name)
                            }
                        } else if role == Player.morgana.rawValue {
                            let name = currPlayer["name"] as? String
                            if let name = name {
                                visibleInfo.append(name)
                            }
                        }
                    }
                    powerLabel.text = "Merlin or morgana: " + visibleInfo.joined(separator: ", ")
                default:
                    powerLabel.text = ""
                }
            }
        }
        
        let constraints = [
            roleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            roleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            roleLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            powerLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            powerLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            powerLabel.topAnchor.constraint(equalTo: roleLabel.bottomAnchor, constant: 50),
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
