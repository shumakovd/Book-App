//
//  HomeHeaderTVCell.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import UIKit

class HomeHeaderTVCell: UITableViewHeaderFooterView {
    
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    
    // MARK: - Properties -
    
    private var titleString: String?
    
    
    // MARK: - Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Public Methods -
    
    func configureCell(_ title: String?) {
        titleString = title
        //
        configureUI()
    }
    
    
    // MARK: - Private Methods -
    
    private func configureUI() {
        titleLabel.text = titleString
    }
}
