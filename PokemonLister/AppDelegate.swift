//
//  AppDelegate.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateInitialViewController()
        
        if let pokemonListViewController = rootViewController?.children.first as? PokemonListViewController {
            let urlSession = URLSession(configuration: .default)
            let networkController = NetworkController(session: urlSession)
            let fetchPokemonListUseCase = FetchPokemonListUseCase(networkController: networkController, delegate: pokemonListViewController)
            pokemonListViewController.fetchPokemonListUseCase = fetchPokemonListUseCase
        }
        
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true

    }

}

