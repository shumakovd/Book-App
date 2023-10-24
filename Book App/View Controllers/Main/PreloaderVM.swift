//
//  PreloaderVM.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import UIKit

class PreloaderVM {
    
    // MARK: - Private Properties
        
    private weak var navigation: AppNavigation?
    
    
    // MARK: - Inits
    
    init(navigation: AppNavigation) {
        self.navigation = navigation
    }
    
    
    // MARK: - Deinit
    
    deinit {
        print("• Preloader Deinit •")
    }
        
    
    // MARK: - Navigation Methods
    
    func goToHome() {
        navigation?.home()
    }
}
