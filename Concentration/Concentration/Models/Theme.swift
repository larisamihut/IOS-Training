//
//  Themes.swift
//  Concentration
//
//  Created by Larisa Diana Mihuț on 31.03.2021.
//

import Foundation

struct Theme {
        
    // MARK: - Utils
    
    func getNewTheme(theme: String) -> [String]? {
        switch theme {
        case "Hearts":
            return ["❤️","🧡","💛","💚","💙","💜","🖤","🤎"]
        case "Books":
            return ["📓","📔","📒","📕","📗","📘","📙","📚"]
        case "Random":
            return ["👻","🥁","🎨","🏵","🤽‍♂️","🎧","🎻","📎"]
        case "Views":
            return ["🗾","🎑","🏞","🌅","🌄","🌠","🎇","🌃"]
        default:
            return ["👻","🥁","🎨","🏵","🤽‍♂️","🎧","🎻","📎"]
        }
    }
}
