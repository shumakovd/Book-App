//
//  BookControlTVCell.swift
//  Book App
//
//  Created by Shumakov Dmytro on 22.10.2023.
//

import UIKit

protocol BookControlDelegate: AnyObject {
    func readNow()
}

class BookControlTVCell: BaseTVCell {
    
    
    // MARK: - IBOutlets -
    
    // View
    @IBOutlet private weak var readNowButton: UIButton!
           
    
    // MARK: - Properties -
        
    private weak var delegate: BookControlDelegate?
    
    
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

    func configureCell(_ delegate: BookControlDelegate?) {
        self.delegate = delegate
    }
    
    
    // MARK: - IBActions -
    
    @IBAction private func readNowAction(_ sender: UIButton) {
        delegate?.readNow()
    }
}
