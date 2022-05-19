//
//  SearchPresenter.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 13.03.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchPresentationLogic
{
    func presentClubs(clubs: [ClubModel])
}

class SearchPresenter: SearchPresentationLogic
{
    weak var viewController: SearchDisplayLogic?
    
    // MARK: Do something
    
    func presentClubs(clubs: [ClubModel])
    {
        var clubViews: [Club] = []
        for club in clubs {
            clubViews.append(Club(name: club.name ?? "Пусто", description: club.description ?? "Пусто", id: club.id))
        }
        viewController?.displayClubs(clubs: clubViews)
    }
}
