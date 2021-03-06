//
//  ClubModels.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 14.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ClubData
{
    // MARK: Use cases
    
    enum Info
    {
        struct Request: Codable
        {
            var id: Int
        }
        struct Response: Codable
        {
            var id: Int
            var name: String
            var description: String
            var avatarPath: String?
            var administrator: User.Response
            var events: [Event]
        }
        
        struct Event: Codable {
            var name: String?
            var description: String?
            var dateTime: String?
            var place: String?
        }
        struct ViewModel
        {
        }
    }
}
