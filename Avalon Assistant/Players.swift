//
//  Players.swift
//  Avalon Assistant
//
//  Created by Meg on 3/10/18.
//  Copyright © 2018 meggrasse. All rights reserved.
//

import Foundation

protocol PlayerInfo {
    var name: String { get }
}

enum Player : Int, PlayerInfo {
    case normalGood = 1
    case normalBad
    case merlin
    case percival
    case assassin
    case morgana
    case mordred
    case oberon
    
    var name: String {
        switch self {
            case .normalGood:
                return "Loyal Servant of Arthur"
            case .normalBad:
                return "Minion of Mordred"
            case .merlin:
                return "Merlin"
            case .percival:
                return "Percival"
            case .assassin:
                return "Assassin"
            case .morgana:
                return "Morgana"
            case .mordred:
                return "Mordred"
            case .oberon:
                return "Oberon"
        }
    }
    
    var isGood: Bool {
        switch self {
        case .normalGood, .merlin, .percival:
            return true
        default:
            return false
        }
    }
}

// figure out if this is a good way to do this
//let goodPlayers : Set = [.merlin, .normalGood, .assassin]

