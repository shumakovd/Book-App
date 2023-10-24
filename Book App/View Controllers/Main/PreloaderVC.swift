//
//  PreloaderVC.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import UIKit

class PreloaderVC: BaseVC {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var progressView: UIProgressView!
    
    
    // MARK: - Properties -
    
    var viewModel: PreloaderVM?
    
    
    // MARK: - Private Properties -
    
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        simulateLoading()
    }
    
    
    // MARK: - Methods -
    
    private func simulateLoading() {
        let totalDuration: TimeInterval = 2.0
        let updateInterval: TimeInterval = 0.1
        var elapsedTime: TimeInterval = 0.0
        
        Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { timer in
            elapsedTime += updateInterval
            
            let loadProgress = Float(elapsedTime / totalDuration)
            self.progressView.setProgress(loadProgress, animated: true)
            
            if elapsedTime >= totalDuration {
                timer.invalidate()
                DispatchQueue.main.async {
                    self.viewModel?.goToHome()
                }
            }
        }
    }
}
