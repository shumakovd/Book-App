//
//  HomeVC.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import UIKit
import Firebase

class HomeVC: BaseVC {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var pageControl: UIPageControl!
        
    
    // MARK: - Properties -
    
    var viewModel: HomeVM?
    
    
    // MARK: - Private Properties -
    
    private var books: BooksML?
    private var banners: [BannerML]?
    
    private var currentPage: Int = 0 {
        willSet {
            pageControl.currentPage = newValue
        }
    }
    
    // Max items visible at the same time.
    private let buffer = 1
    private var totalElements = 1
    
    // Timer
    private var autoScrollTimer: Timer?

    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        tableViewSetup()
        collectionViewSetup()
                
        // Data
        loadData()
        
        // Auto Scrtoll
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    deinit {
        autoScrollTimer?.invalidate()
    }
    
    // MARK: - Methods -
    
    private func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        //
        tableView.sectionHeaderTopPadding = 0
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Cells
        HomeSectionTVCell.registerForTableView(aTableView: tableView)
        
        // Header
        tableView.register(UINib(nibName: HomeHeaderTVCell.reuseIdentifier, bundle: nil),
                           forHeaderFooterViewReuseIdentifier: HomeHeaderTVCell.reuseIdentifier)
    }
    
    private func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        //
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        BannerCVCell.registerForCollectionView(aCollectionView: collectionView)
    }
    
    
    // Scroll
    
    @objc func autoScroll() {
        let totalItems = collectionView.numberOfItems(inSection: 0)
        guard totalItems > 0 else { return }

        var nextItem = currentPage + 1
        if nextItem >= totalItems {
            nextItem = 0
        }

        let indexPath = IndexPath(item: nextItem, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
  
               
    
    // MARK: - Network Methods -
               
    private func loadData() {
        
        viewModel?.loadData {
            // Data
            self.books = AppConfiguration.books
            self.banners = AppConfiguration.banners
            
            // Page Control
            self.pageControl.numberOfPages = self.banners?.count ?? 0
            
            // Reload Data
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }
        
}


// MARK: - Extensions -


// MARK: - BookSection Delegate -

extension HomeVC: BookSectionDelegate {
    func bookDetails(_ model: BookML?) {
        viewModel?.goToHomeDetails(model)
    }
}


// MARK: - UIScrollView Delegate -

extension HomeVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let count = banners?.count ?? 0
        let itemSize = collectionView.contentSize.width / CGFloat(totalElements)
        
        // Right
        if scrollView.contentOffset.x > itemSize * CGFloat(count){
            collectionView.contentOffset.x -= itemSize * CGFloat(count)
        }
        
        // Left
        if scrollView.contentOffset.x < 0  {
            collectionView.contentOffset.x += itemSize * CGFloat(count)
        }
    }
}

// MARK: - UICollectionView Delegate -

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Sections
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    // MARK: - Rows in section
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalElements = buffer + (banners?.count ?? 0)
        return totalElements
    }
    
    // MARK: - Cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCVCell.cellIdentifier, for: indexPath) as? BannerCVCell else { return UICollectionViewCell() }
                       
        // Index        
        var currentCell: Int = 0
        
        if let bannersCount = banners?.count, bannersCount > 0 {
            currentCell = indexPath.row % bannersCount
        }
        
        cell.configureCell(banners?[currentCell])
        return cell
    }
    
    // MARK: - Select Items
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let books = books?.books else { return }
        var book: BookML?
        let selectedBanner = banners?[indexPath.row]
        
        for each in books {
            if each.id == selectedBanner?.book_id {
                book = each
            }
        }
        
        viewModel?.goToHomeDetails(book)
    }
    
    // MARK: - Will Display
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        

        if let bannersCount = banners?.count, bannersCount > 0 {
            let visibleIndexPaths = collectionView.indexPathsForVisibleItems

            if let firstVisibleIndexPath = visibleIndexPaths.first {
                if indexPath.row > firstVisibleIndexPath.row {
                    // Right Swipe
                    currentPage = (currentPage + 1) % bannersCount
                } else if indexPath.row < firstVisibleIndexPath.row {
                    // Left Swipe
                    if currentPage == 0 {
                        currentPage = bannersCount
                    } else {
                        currentPage = (currentPage - 1) % bannersCount
                    }
                }
            }
        }
    }
    
   
    // MARK: - Layout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
}


// MARK: - UITableView Delegate -

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.books?.ganres?.count ?? 0
    }
    
    // MARK: - Rows in section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // MARK: - Height
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 198
    }
    
    // MARK: - Cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeSectionTVCell.cellIdentifier, for: indexPath) as? HomeSectionTVCell else { return UITableViewCell() }
        
        cell.configureCell(self.books?.ganres?[indexPath.section].books, delegate: self)
        return cell
    }        
    
    // MARK: - Header
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderTVCell.reuseIdentifier) as? HomeHeaderTVCell else { return nil }
        
        headerView.configureCell(self.books?.ganres?[section].genre)
        return headerView
    }
    
    // MARK: - Footer
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
