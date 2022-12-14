//
//  Themes.swift
//  Concentration
//
//  Created by Larisa Diana Mihuศ on 31.03.2021.
//

import Foundation

struct Theme {
        
    // MARK: - Utils
    
    func getNewTheme(theme: String) -> [String]? {
        switch theme {
        case "Hearts":
            return ["โค๏ธ","๐งก","๐","๐","๐","๐","๐ค","๐ค"]
        case "Books":
            return ["๐","๐","๐","๐","๐","๐","๐","๐"]
        case "Random":
            return ["๐ป","๐ฅ","๐จ","๐ต","๐คฝโโ๏ธ","๐ง","๐ป","๐"]
        case "Views":
            return ["๐พ","๐","๐","๐","๐","๐ ","๐","๐"]
        default:
            return ["๐ป","๐ฅ","๐จ","๐ต","๐คฝโโ๏ธ","๐ง","๐ป","๐"]
        }
    }
}
