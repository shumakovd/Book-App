//
//  BannerCVCell.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import UIKit

class BannerCVCell: BaseCVCell {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var bannerImageView: UIImageView!
    
    
    // MARK: - Properties -
    
    private var model: BannerML?
    
    
    // MARK: - Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //
        model = nil
        bannerImageView.image = nil
    }
    
    override class var cellIdentifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Methods -
    
    func configureCell(_ model: BannerML?) {
        self.model = model
        //
        configureUI()
    }
    
    private func configureUI() {
        // Image View
        if bannerImageView.image == nil {
            bannerImageView.setImage(url: model?.cover)
        }
    }
}
