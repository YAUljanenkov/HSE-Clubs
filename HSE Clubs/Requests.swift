//
//  File.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 29.04.2022.
//

import UIKit

let host = "http://localhost:5000/api"

enum RequestRoutes {
    case loginUser
    case getUser(String)
    
    static func getRoute(_ route: RequestRoutes) -> String {
        switch route {
        case let .getUser(user):
            return "\(host)/user/\(user)/get/"
        case .loginUser:
            return "\(host)/user/login/"
        }
    }
}
