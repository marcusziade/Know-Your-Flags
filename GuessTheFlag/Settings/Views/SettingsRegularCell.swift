//
//  SettingsItemCell.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 24.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import UIKit

final class SettingsRegularCell: SettingsCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addAndConstrainSubview(accessoryView) {
            $0.top.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configure(with item: SettingsItem) {
        itemBadgeView.configure(
            with: UIImage(systemName: item.image)!,
            color: item.color
        )
        titleLabel.text = item.title
    }
    
    // MARK: - Private
    
    private let accessoryView = UIImageView(image: UIImage(systemName: "chevron.forward")).configure {
        $0.contentMode = .scaleAspectFit
    }
}
