//
//  Emoji.swift
//  PollutionEmoji
//
//  Created by Antonio Favata on 23/04/2018.
//  Copyright © 2018 GNM. All rights reserved.
//

import Foundation

extension Int {
    var emoji: String {
        switch self {
        case 1:
            return "😍"
        case 2:
            return "🤩"
        case 3:
            return "😎"
        case 4:
            return "😏"
        case 5:
            return "🤨"
        case 6:
            return "😷"
        case 7:
            return "🤢"
        case 8:
            return "🤮"
        case 9:
            return "😵"
        default:
            return "☠️"
        }
    }
}
