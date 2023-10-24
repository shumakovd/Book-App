//
//  AppConfiguration.swift
//  Book App
//
//  Created by Shumakov Dmytro on 22.10.2023.
//

import Foundation

class AppConfiguration {
    
    static var shared: AppConfiguration = {
        return AppConfiguration()
    }()
    
    private init() {}
    
    
    // MARK: - Properties -
    
    static var books: BooksML?
    static var banners: [BannerML]?
    static var carouselBooks: [BookML]?
    static var suggestedBooks: [BookML]?
    
    
    // MARK: - Methods -
        
    func getJSONData(_ completion: @escaping () -> Void) {
        FirebaseManager.shared.getJSON { [weak self] result, error in
            guard let _ = self else { return }
            
            if let result = result {
                // Books
                var books = BooksML(books: result.books)
                books.sortBooksByGenre()
                // Sorted
                AppConfiguration.books = books
                
                // Banners
                let banners = BannersML(banners: result.banners)
                AppConfiguration.banners = banners.banners
                
                // Suggested
                if let suggestedIds = result.suggestedIds {
                    let suggestedBooks = books.books?.filter({ book in
                        if let id = book.id, suggestedIds.contains(id) {
                            return true
                        }
                        return false
                    })
                    AppConfiguration.suggestedBooks = suggestedBooks
                }
                
                print(" Suggested BOKS: ", AppConfiguration.suggestedBooks)
                
                completion()
            }
        }
    }
    
    func getCarouselBooks(_ completion: @escaping () -> Void) {
        FirebaseManager.shared.getCarouselBooks { [weak self] result, error in
            guard let _ = self else { return }
            
            if let result = result {
                // Books
                var books = BooksML(books: result.books)
                books.sortBooksByGenre()
                // Sorted
                AppConfiguration.carouselBooks = books.books
                
                completion()
            }
        }
    }    
}
