//
//  FirebaseManager.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseRemoteConfig


class FirebaseManager {
 
    static var shared: FirebaseManager = {
        return FirebaseManager()
    }()
    
    private init() {}
    
    
    // MARK: - Properties -
        
    private let reference = Database.database().reference()
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    
    // MARK: - Methods -
    
    func getJSON(_ completion: @escaping (_ result: JSONML?, _ error: String?) -> Void) {
        
        // Fetch
        remoteConfig.fetch { status, error in
            if status == .success {
                self.remoteConfig.activate { _, _ in
                    let jsonValue = self.remoteConfig.configValue(forKey: "json_data").jsonValue
                    
                    do {
                        let data = try FirebaseDecoder().decode(JSONML.self, from: jsonValue)
                        
                        // Completion
                        completion(data, nil)
                        
                    } catch let error {
                        print("• getJSON(_:), Error: ", error.localizedDescription)
                        completion(nil, nil)
                    }
                    
                    // print("JSON: \(jsonValue)")
                }
            } else {
                print("Remote Config fetch failed with error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    // FIXME: The Same Books. 
    func getCarouselBooks(_ completion: @escaping (_ result: BooksML?, _ error: String?) -> Void) {
        
        // Fetch
        remoteConfig.fetch { status, error in
            if status == .success {
                self.remoteConfig.activate { _, _ in
                    let jsonValue = self.remoteConfig.configValue(forKey: "details_carousel").jsonValue
                    
                    do {
                        let data = try FirebaseDecoder().decode(BooksML.self, from: jsonValue)

                        // Completion
                        completion(data, nil)

                    } catch let error {
                        print("• getDetailsCarousel(_:), Error: ", error.localizedDescription)
                        completion(nil, nil)
                    }
                    
                    // print("Carousel JSON: \(jsonValue)")
                }
            } else {
                print("Remote Config fetch failed with error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
