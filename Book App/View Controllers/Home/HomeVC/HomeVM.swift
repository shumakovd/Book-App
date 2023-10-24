//
//  HomeVM.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import UIKit

class HomeVM {
        
    // MARK: - Private Properties
    
    private weak var navigation: HomeNavigation?
    
    
    // MARK: - Inits
    
    init(navigation: HomeNavigation) {
        self.navigation = navigation
    }
    
    
    // MARK: - Deinit
    
    deinit {
        print("• HomeVM Deinit •")
    }
    
    
    // MARK: - Methods -
    
    func loadData(_ completion: @escaping () -> Void) {
        
        let group = DispatchGroup()
        
        group.enter()
        AppConfiguration.shared.getJSONData {
            group.leave()
        }
        
        group.enter()
        AppConfiguration.shared.getCarouselBooks {
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    
    // MARK: - Navigation Methods -
    
    func goToHomeDetails(_ model: BookML?) {
        navigation?.goToHomeDetails(model)
    }
}
