//
//  BookDetailsTVCell.swift
//  Book App
//
//  Created by Shumakov Dmytro on 22.10.2023.
//

import UIKit

class BookDetailsTVCell: BaseTVCell {
    
    
    // MARK: - IBOutlets -
    
    // View
    @IBOutlet private weak var mainView: UIView!
           
    // Labels
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var quotesLabel: UILabel!
    @IBOutlet private weak var readersLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    
    
    // MARK: - Properties -
        
    private var model: BookML?
    
    
    // MARK: - Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
          
    // MARK: - Methods -

    func configureCell(_ model: BookML?) {
        self.model = model
        //
        configureUI()
    }
    
    private func configureUI() {
        guard let model = model else { return }
        
        // View
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 16
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
        // Texts
        genreLabel.text = model.genre
        likesLabel.text = model.likes
        quotesLabel.text = model.quotes
        readersLabel.text = model.views
        summaryLabel.text = model.summary
    }
}
