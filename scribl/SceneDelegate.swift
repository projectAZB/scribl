//
//  SceneDelegate.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: scene)
        let navController = UINavigationController(rootViewController: GalleryViewController(viewModel: GalleryViewModel()))
        configureNavBarAppearance(navController: navController)
        window.rootViewController = navController
        self.window = window
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    private func configureNavBarAppearance(navController: UINavigationController) {
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.tintColor = .pureBlack()
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithDefaultBackground()
            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = .whiteLilac()
            
            navController.navigationBar.standardAppearance = navBarAppearance
            navController.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        else {
            navController.navigationBar.backgroundColor = .whiteLilac()
        }
    }


}

