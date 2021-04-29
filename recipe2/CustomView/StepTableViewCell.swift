//
//  StepTableViewCell.swift
//  recipe2
//
//  Created by LIM MEI TING on 27/04/2021.
//

import UIKit

class StepTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBg: UIView!
    @IBOutlet weak var stepLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func setupCell(step: Step) {
        
        self.stepLabel.sizeToFit()
        self.stepLabel.numberOfLines = 0
        self.stepLabel.text = step.desc
        
        cellBg.layer.masksToBounds = false
        cellBg.layer.shadowColor = UIColor.gray.cgColor
          
        cellBg.layer.borderWidth = 1.0
        cellBg.layer.cornerRadius = 5.0
        cellBg.layer.borderColor = UIColor(red:0.00, green:0.87, blue:0.39, alpha:1.0).cgColor

    }
    
    class var reuseIdentifier: String {
        return "StepTableViewCellReuseIdentifier"
    }
    class var nibName: String {
        return "StepTableViewCell"
    }
    
}
