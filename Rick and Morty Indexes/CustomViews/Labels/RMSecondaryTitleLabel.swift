//
//  RMSecondaryTitleLabel.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 25/6/22.
//

import UIKit

class RMSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat, textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        self.textAlignment = textAlignment
        configure()
    }
    
    
    private func configure() {
        textColor = .white
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
