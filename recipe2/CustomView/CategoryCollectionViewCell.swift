//
//  CategoryCollectionViewCell.swift
//  recipe2
//
//  Created by LIM MEI TING on 27/04/2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgCategory: UIView!
    @IBOutlet weak var labelCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgCategory.layer.cornerRadius = 10
        
        // Initialization code
    }
    
    func setupCell(name: String) {
        self.labelCategory.text = name
    }
    
    
    
    class var reuseIdentifier: String {
        return "CategoryCollectionViewCellReuseIdentifier"
    }
    class var nibName: String {
        return "CategoryCollectionViewCell"
    }

}


