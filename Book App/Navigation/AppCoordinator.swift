//
//  AppCoordinator.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import UIKit

// MARK: - Protocols -

protocol AppNavigation: AnyObject {
    func home()
    func preloader()
}

protocol HomeNavigation: AnyObject {
    func goToHome()
    func goToHomeDetails(_ model: BookML?)
    func backToPreviousVC()
}


// MARK: - Coordinator -

class AppCoordinator {
    
    // MARK: - Properties

    internal var navigationController: UINavigationController

    // MARK: - Initializators

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Navigation Methods
    
    func startWithPreloader() {
        // Create and configure PreloaderVC
        let viewController = createPreloaderVC()
           
        // Set the navigation stack to contain only the new PreloaderVC
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func startWithHome() {
        // Create and configure HomeVC
        let viewController = createHomeVC()
        // Set the navigation stack to contain only the new HomeVC
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func backAction() {
        navigationController.popViewController(animated: true)
    }
}


// MARK: - App Navigation -

extension AppCoordinator: AppNavigation {
    func home() {
        startWithHome()
    }
    
    func preloader() {
        startWithPreloader()
    }
}


// MARK: - Home Navigation -

extension AppCoordinator: HomeNavigation {
    func goToHome() {
        // Create and configure HomeVC
        let viewController = createHomeVC()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToHomeDetails(_ model: BookML?) {
        // Create and configure HomeDetailsVC
        let viewController = createHomeDetailsVC(model)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func backToPreviousVC() {
        backAction()
    }
}


// MARK: - Creating Controllers -

extension AppCoordinator {
    
    private func createPreloaderVC() -> PreloaderVC {
        let viewController: PreloaderVC = createMainViewController(identifier: ViewControllersIDs.MainStoryboard.PreloaderVC)
        let viewModel = PreloaderVM(navigation: self)
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func createHomeVC() -> HomeVC {
        let viewController: HomeVC = createHomeViewController(identifier: ViewControllersIDs.HomeStoryboard.HomeVC)
        let viewModel = HomeVM(navigation: self)
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func createHomeDetailsVC(_ model: BookML?) -> HomeDetailsVC {
        let viewController: HomeDetailsVC = createHomeViewController(identifier: ViewControllersIDs.HomeStoryboard.HomeDetailsVC)
        let viewModel = HomeDetailsVM(navigation: self, model: model)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension AppCoordinator {
    
    // Base method for creating view controllers Main Storyboard
    private func createMainViewController<T: UIViewController>(identifier: String) -> T {
        return AppCoordinator.MainStoryboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    // Base method for creating view controllers Home Storyboard
    private func createHomeViewController<T: UIViewController>(identifier: String) -> T {
        return AppCoordinator.HomeStoryboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
