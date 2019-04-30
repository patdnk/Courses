//
//  AccessoryCell.swift
//  My IT Course
//
//  Created by Pat Dynek on 21/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//
//
import UIKit

protocol AccessoryCellDelegate: class {
    func didTapActionButton(selected: Bool, sender: UIButton)
}

class AccessoryCell: UITableViewCell {
    
    var actionButton = UIButton(type: .custom)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    weak var delegate: AccessoryCellDelegate?
    var indexPath: IndexPath!
    private var isTicked: Bool = false
    
    private func setupActionButton() {
        self.actionButton.backgroundColor = .clear
        self.actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        self.addSubview(self.actionButton)
    }
    
    @IBAction func didTapActionButton() {
        self.accessoryType =  self.isTicked ? .none : .checkmark
        self.isTicked = !self.isTicked
        self.delegate?.didTapActionButton(selected: self.isTicked, sender: self.actionButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.actionButton.frame = CGRect(origin: CGPoint(x: self.frame.width - 38, y: (self.contentView.frame.height - 30) / 2), size: CGSize(width: 30, height: 30))
    }

}
