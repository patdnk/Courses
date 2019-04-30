//
//  DetailsCell.swift
//  My IT Course
//
//  Created by Pat Dynek on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

protocol DetailsCellDelegate: class {
    func didTapActionButton(sender: UIButton)
}

class DetailsCell: UITableViewCell {
    
    var actionButton = UIButton(type: .custom)
    weak var delegate: DetailsCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.setupActionButton()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setupActionButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupActionButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.actionButton.frame = CGRect(origin: CGPoint(x: self.frame.width - 38, y: (self.contentView.frame.height - 30) / 2), size: CGSize(width: 75, height: 30))
    }
    
    private func setupActionButton() {
        self.actionButton.backgroundColor = .clear
        self.actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        self.addSubview(self.actionButton)
    }
    
    @IBAction func didTapActionButton() {
        self.delegate?.didTapActionButton(sender: self.actionButton)
    }
    
}
