//
//  CarouselCVCell.swift
//  Book App
//
//  Created by Shumakov Dmytro on 22.10.2023.
//

import UIKit

class CarouselCVCell: BaseCVCell {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var bookImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    
    
    // MARK: - Properties -
    
    private var model: BookML?

    
    // MARK: - Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //
        model = nil
        bookImageView.image = nil
    }
    
    override class var cellIdentifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Methods -
    
    func configureCell(_ model: BookML?) {
        self.model = model
        //
        configureUI()
    }
    
    private func configureUI() {
        // Labels
        nameLabel.text = model?.name
        authorLabel.text = model?.author
        
        // Image View
        if bookImageView.image == nil {
            bookImageView.setImage(url: model?.cover_url)
        }
    }
}
