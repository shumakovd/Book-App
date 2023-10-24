//
//  SuggestedCVCell.swift
//  Book App
//
//  Created by Shumakov Dmytro on 22.10.2023.
//

import UIKit

class SuggestedCVCell: BaseCVCell {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var bookImageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    
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
        guard let model = model else { return }
            
        // Texts
        titleLabel.text = model.name
                
        // Image
        if bookImageView.image == nil {
            bookImageView.setImage(url: model.cover_url)
        }
    }
}
