//
//  AppCoordinatorExt.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import UIKit

extension AppCoordinator {
    
    // Storyboards
    static var MainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    static var HomeStoryboard = UIStoryboard.init(name: "Home", bundle: nil)
    
    // View Controllers IDs
    enum ViewControllersIDs {
        
        enum MainStoryboard {
            static let PreloaderVC = "PreloaderVC"
        }
             
        enum HomeStoryboard {
            static let HomeVC = "HomeVC"
            static let HomeDetailsVC = "HomeDetailsVC"
        }
    }
}
