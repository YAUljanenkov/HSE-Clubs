//
//  SearchViewController.swift
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


protocol SearchDisplayLogic: AnyObject
{
    func displayClubs(clubs: [Club])
}

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SearchDisplayLogic
{
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    let search = UISearchController()
    var clubs: [Club] = []
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    init() {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layoutFlow = UICollectionViewCompositionalLayout.list(using: config)
        super.init(collectionViewLayout: layoutFlow)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        updateInformation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.searchController = search
        search.searchBar.placeholder = "Поиск клубов"
        self.tabBarController?.title = "Поиск"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.navigationItem.searchController = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: Double(view.frame.width), height: ClubCell.cellSize + 20.0)
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = true
        view.addSubview(collectionView)
        collectionView.register(ClubCell.self, forCellWithReuseIdentifier: ClubCell.cellId)
        collectionView.backgroundColor = .white
    }
    
    func updateInformation()
    {
        print("update Information")
        interactor?.loadClubs()
    }
    
    func displayClubs(clubs: [Club])
    {
        self.clubs = clubs
        print("display Clubs")
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClubCell.cellId, for: indexPath) as! ClubCell
        cell.layer.masksToBounds = true
        let club = self.clubs[indexPath.row]
        cell.customize(name: club.name, description: club.description, avatar: club.avatar)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.clubs.count
    }
}
