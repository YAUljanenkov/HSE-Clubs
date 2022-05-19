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
    case getClubs
    case createClub
    case getClub(Int)
    case createEvent
    case getEvents
    
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
        case .getClubs:
            components.path = "/api/club/get_all_clubs"
        case .createClub:
            components.path = "/api/club/create"
        case let .getClub(id):
            components.path = "/api/club/get/\(id)"
        case .createEvent:
            components.path = "/api/event/create"
        case .getEvents:
            components.path = "/api/event/get_events"
        }
        return components.url
    }
}
