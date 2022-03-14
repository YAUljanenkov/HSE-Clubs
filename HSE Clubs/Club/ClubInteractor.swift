//
//  ClubInteractor.swift
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

protocol ClubBusinessLogic
{
  func doSomething(request: ClubData.Something.Request)
}

protocol ClubDataStore
{
  //var name: String { get set }
}

class ClubInteractor: ClubBusinessLogic, ClubDataStore
{
  var presenter: ClubPresentationLogic?
  var worker: ClubWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: ClubData.Something.Request)
  {
    worker = ClubWorker()
    worker?.doSomeWork()
    
    let response = ClubData.Something.Response()
    presenter?.presentSomething(response: response)
  }
}