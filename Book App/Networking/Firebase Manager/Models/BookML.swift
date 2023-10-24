//
//  BookML.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import Foundation

// MARK: - Ganre Model -

struct GenreBooks {
    let genre: String
    let books: [BookML]
}

// MARK: - Books Model -

struct BooksML: Codable {
    let books: [BookML]?
    var ganres: [GenreBooks]?

    enum CodingKeys: String, CodingKey {
        case books
    }
    
    mutating func sortBooksByGenre() {
        guard let books = books else { return }
        
        // Use a dictionary to group books by genre
        var genreDictionary: [String: [BookML]] = [:]
        
        for book in books {
            if let genre = book.genre {
                if genreDictionary[genre] == nil {
                    genreDictionary[genre] = [book]
                } else {
                    genreDictionary[genre]?.append(book)
                }
            }
        }
        
        // Create GenreBooks objects
        var genreBooks: [GenreBooks] = []
        for (genre, books) in genreDictionary {
            genreBooks.append(GenreBooks(genre: genre, books: books))
        }
        
        // Sort genreBooks by genre in alphabetical order
        self.ganres = genreBooks.sorted(by: { $0.genre < $1.genre })
    }
}

extension BooksML {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        books = try? values.decode([BookML].self, forKey: .books)                
    }
}


// MARK: - Book Model -

struct BookML: Codable {
    
    let id: Int?
    
    let name: String?
    let author: String?
    let summary: String?
    
    let genre: String?
            
    let views: String?
    let likes: String?
    let quotes: String?
    
    let cover_url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, author, summary
        case genre
        case views, likes, quotes
        case cover_url
    }
}

extension BookML {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int.self, forKey: .id)
        
        name = try? values.decode(String.self, forKey: .name)
        author = try? values.decode(String.self, forKey: .author)
        summary = try? values.decode(String.self, forKey: .summary)
        
        genre = try? values.decode(String.self, forKey: .genre)
        
        views = try? values.decode(String.self, forKey: .views)
        likes = try? values.decode(String.self, forKey: .likes)
        quotes = try? values.decode(String.self, forKey: .quotes)
        
        cover_url = try? values.decode(String.self, forKey: .cover_url)
    }
}
