//
//  FilterTableViewCell.swift
//  KODEtest
//
//  Created by Vicodin on 16.03.2024.
//

import UIKit

class SortingTableViewCell: UITableViewCell {
    
    private let markerPosition: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor(rgb: 0x6534FF)
        return $0
    }(UIImageView())
    
    private let titlePosition: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = UIFont(name: "Inter-Medium", size: 16)
        $0.textColor = UIColor(rgb: 0x050510)
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(cellTag: Int, data: SortingData) {
        if cellTag == UserSettings.sortMarkerState {
            markerPosition.image = UIImage(systemName: "record.circle.fill")
        } else {
            markerPosition.image = UIImage(systemName: "circle")
        }
        titlePosition.text = data.titlePositionName[cellTag]
    }
    
    private func layout() {
        [markerPosition, titlePosition].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            markerPosition.heightAnchor.constraint(equalToConstant: 24),
            markerPosition.widthAnchor.constraint(equalToConstant: 24),
            markerPosition.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            markerPosition.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titlePosition.centerYAnchor.constraint(equalTo: markerPosition.centerYAnchor),
            titlePosition.leadingAnchor.constraint(equalTo: markerPosition.trailingAnchor, constant: 12)
        ])
    }
}
