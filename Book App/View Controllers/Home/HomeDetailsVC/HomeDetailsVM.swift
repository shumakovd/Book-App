//
//  HomeDetailsVM.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import UIKit

class HomeDetailsVM {
    
    // MARK: - Private Properties
    
    private weak var navigation: HomeNavigation?
        
    
    // MARK: - Properties
    
    var currentBook: BookML?
    
    
    // MARK: - Inits
    
    init(navigation: HomeNavigation, model: BookML?) {
        self.navigation = navigation
        self.currentBook = model
    }
    
    
    // MARK: - Deinit
    
    deinit {
        print("• HomeDetailsVM Deinit •")
    }
    
    
    // MARK: - Methods

    func back() {
        navigation?.backToPreviousVC()
    }
}
