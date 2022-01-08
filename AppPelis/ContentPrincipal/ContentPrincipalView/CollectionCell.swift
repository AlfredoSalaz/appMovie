//
//  CollectionCell.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 06/01/22.
//

import UIKit

class CollectionCell: UICollectionViewCell{
    
    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var lblNameMovie: UILabel!
    
    var funcActionImage : (() ->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageMovie.isUserInteractionEnabled = true
        imageMovie.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        funcActionImage?()
    }
    
}
