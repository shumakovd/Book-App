//
//  BaseCVCell.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import UIKit

class BaseCVCell: UICollectionViewCell {
    
    // MARK: - Class Methods -
    
    class var className: String {
        return String(describing: self)
    }

    class var cellIdentifier: String {
        assertionFailure("Method 'cellIdentifier' need to be overriden in BaseCollectionViewCell subclass")
        return ""
    }

    class func nibName() -> String {
        return String(describing: className).components(separatedBy: ".").last!
    }

    class func registerForCollectionView(aCollectionView: UICollectionView) {
        let nib = UINib(nibName: className, bundle: nil)
        aCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
}
