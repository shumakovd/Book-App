//
//  SuggestedTVCell.swift
//  Book App
//
//  Created by Shumakov Dmytro on 22.10.2023.
//

import UIKit

class SuggestedTVCell: BaseTVCell {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    // MARK: - Properties -
    
    private var models: [BookML]? = []
    
    
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
    
    func configureCell(_ models: [BookML]?) {
        self.models = models
        //
        configureUI()
    }
    
    private func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        //
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        //
        SuggestedCVCell.registerForCollectionView(aCollectionView: collectionView)
    }
    
    private func configureUI() {
        guard let models = models else { return }
        
        if !models.isEmpty {
            collectionView.reloadData()
        }
    }
}

extension SuggestedTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestedCVCell.cellIdentifier, for: indexPath) as? SuggestedCVCell else { return UICollectionViewCell() }
                       
        cell.configureCell(models?[indexPath.item])
        return cell
    }
    
    // MARK: - Select Items
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Book selected: ", models?[indexPath.row])
    }
    
    // MARK: - Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                            
        return CGSize(width: 120, height: 198)
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 8.0
    }
}
