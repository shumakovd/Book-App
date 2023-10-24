//
//  HomeDetailsVC.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import UIKit

class HomeDetailsVC: BaseVC {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var backButton: UIButton!
    
    // MARK: - Properties -
    
    var viewModel: HomeDetailsVM?
    
    
    // MARK: - Private Properties -
    
    private var books: [BookML]?
    private var currentBook: BookML?
    private var suggestedBooks: [BookML]?
    
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        tableViewSetup()
        //
        getModels()
    }
    
    
    // MARK: - Methods -
        
    private func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        //
        tableView.sectionHeaderTopPadding = 0
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Cells
        CarouselTVCell.registerForTableView(aTableView: tableView)
        BookDetailsTVCell.registerForTableView(aTableView: tableView)
        SuggestedTVCell.registerForTableView(aTableView: tableView)        
        BookControlTVCell.registerForTableView(aTableView: tableView)
    }
    
    
    // MARK: - Private Methods -
    
    private func getModels() {
        currentBook = viewModel?.currentBook
        
        books = AppConfiguration.carouselBooks
        suggestedBooks = AppConfiguration.suggestedBooks
        
        // Move the current book to the beginning
        if let currentBook = currentBook, let bookId = currentBook.id {
            if let bookIndex = books?.firstIndex(where: { $0.id == bookId }) {
                if let bookToMove = books?.remove(at: bookIndex) {
                    self.books?.insert(bookToMove, at: 0)
                }
            }
        }
        
        tableView.reloadData()
    }
    
    
    // MARK: - IBActions -
    
    @IBAction private func backAction(_ sender: UIButton) {
        viewModel?.back()
    }
}


// MARK: - Extensions -


// MARK: - Carousel Delegate -

extension HomeDetailsVC: CarouselDelegate {
    func updateCurrentBook(_ model: BookML?) {
        currentBook = model
        tableView.reloadSections([1], with: .none)
    }
}


// MARK: - BookControl Delegate -

extension HomeDetailsVC: BookControlDelegate {
    func readNow() {
        print("Reade Now Action")
    }
}


// MARK: - UITableView Delegate -

extension HomeDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    // MARK: - Rows in section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // MARK: - Height
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            let proportionWidth = 200.0
            let proportionHeight = 250.0
            
            return (tableView.frame.width / proportionWidth) * proportionHeight
            
        default:
            return UITableView.automaticDimension
        }
    }
    
    // MARK: - Cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarouselTVCell.cellIdentifier, for: indexPath) as? CarouselTVCell else { return UITableViewCell() }

            cell.configureCell(books, delegate: self)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookDetailsTVCell.cellIdentifier, for: indexPath) as? BookDetailsTVCell else { return UITableViewCell() }

            cell.configureCell(currentBook)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SuggestedTVCell.cellIdentifier, for: indexPath) as? SuggestedTVCell else { return UITableViewCell() }

            cell.configureCell(suggestedBooks)
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookControlTVCell.cellIdentifier, for: indexPath) as? BookControlTVCell else { return UITableViewCell() }

            cell.configureCell(self)
            return cell
            
        default:
            return UITableViewCell()
            
        }
    }
    
    // MARK: - Header
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // MARK: - Footer
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
