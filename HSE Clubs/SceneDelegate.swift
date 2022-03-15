//
//  SceneDelegate.swift
//  HSE Clubs
//
//  Created by Ярослав Ульяненков on 08.03.2022.
//

import UIKit
import HSEUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let tabBarController = UITabBarController()
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor(named: "barBackground")
            UITabBar.appearance().standardAppearance = tabBarAppearance

            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
        
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        } 
        
        let viewControllers = [
            SearchViewController(),
            ClubViewController(),
//            UserViewController(),
            UserViewController()
        ]
        tabBarController.setViewControllers(viewControllers, animated: false)
        let nav = UINavigationController(rootViewController: tabBarController)
        window.rootViewController = nav
        self.window = window
        window.makeKeyAndVisible()
        
        guard let items = tabBarController.tabBar.items else { return }
        let titles = ["Поиск", "Клубы",
//                      "Календарь",
                      "Профиль"]
        let imageScale = 32
        
        let images = [
            UIImage(named: "search")?.resize(withSize: CGSize(width: imageScale, height: imageScale)),
            UIImage(named: "people")?.resize(withSize: CGSize(width: imageScale, height: imageScale)),
//            UIImage(named: "calendar")?.resize(withSize: CGSize(width: imageScale, height: imageScale)),
            UIImage(named: "person")?.resize(withSize: CGSize(width: imageScale, height: imageScale))
        ]
        
        for i in 0..<viewControllers.count {
            viewControllers[i].title = titles[i]
            items[i].image = images[i]
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

