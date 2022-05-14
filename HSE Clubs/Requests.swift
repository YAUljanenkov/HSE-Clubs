//
//  File.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 29.04.2022.
//

import UIKit

enum RequestRoutes {
    case loginUser
    case getUser(String)
    case updateUser(String)
    
    static func getRoute(_ route: RequestRoutes) -> URL? {
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 5000
        
        switch route {
        case let .getUser(user):
            components.path =  "/api/user/\(user)/get/"
        case .loginUser:
            components.path =  "/api/user/login/"
        case let .updateUser(user):
            components.path = "/api/user/\(user)/update/"
        }
        return components.url
    }
}
