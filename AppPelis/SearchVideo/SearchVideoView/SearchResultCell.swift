//
//  SearchResultCell.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 08/01/22.
//

import UIKit

class SearchResultCell: UITableViewCell{
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var playVideo: UIButton!
    @IBOutlet weak var lLblTitle: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    var detailMovie: (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func DetailMovie(_ sender: Any) {
        detailMovie?()
    }
}
