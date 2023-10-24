//
//  CarouselTVCell.swift
//  Book App
//
//  Created by Shumakov Dmytro on 22.10.2023.
//

import UIKit
import AnimatedCollectionViewLayout

protocol CarouselDelegate: AnyObject {
    func updateCurrentBook(_ model: BookML?)
}

class CarouselTVCell: BaseTVCell {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    // MARK: - Properties -
    
    private var models: [BookML]? = []
    private weak var delegate: CarouselDelegate?
    
    private var currentBook: BookML? {
        willSet {
            delegate?.updateCurrentBook(newValue)
        }
    }
    
    private var isScrolling = false
    
    
    // MARK: - Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //
        collectionViewSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override class var cellIdentifier: String {
        return String(describing: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Public Methods -
    
    func configureCell(_ models: [BookML]?, delegate: CarouselDelegate?) {
        self.models = models
        self.delegate = delegate
        //
        configureUI()
    }
    
    private func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Layout
        let layout = AnimatedCollectionViewLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        layout.animator = LinearCardAttributesAnimator()
        
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Cells
        CarouselCVCell.registerForCollectionView(aCollectionView: collectionView)
    }
    
    private func configureUI() {
        guard let models = models else { return }
        
        if !models.isEmpty {
            collectionView.reloadData()
        }
    }
}


// MARK: - UIScrollView Delegate -

extension CarouselTVCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        currentBook = models?[currentPage]
    }
}


// MARK: - UICollectionView Delegate -

extension CarouselTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Sections
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    // MARK: - Rows in sections
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models?.count ?? 0
    }
    
    // MARK: - Cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCVCell.cellIdentifier, for: indexPath) as? CarouselCVCell else { return UICollectionViewCell() }
                       
        cell.configureCell(models?[indexPath.item])
        return cell
    }
  
    // MARK: - Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let proportionWidth = 200.0
        let proportionHeight = 250.0
        
        return CGSize(width: collectionView.frame.width, height: (collectionView.frame.width / proportionWidth) * proportionHeight)
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
}
