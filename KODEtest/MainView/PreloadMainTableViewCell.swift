//
//  PreloadMainTableViewCell.swift
//  KODEtest
//
//  Created by Vicodin on 19.03.2024.
//

import UIKit

class PreloadMainTableViewCell: UITableViewCell {

    private let imageForPerson: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "AvatarEllipse")
        return $0
    }(UIImageView())
    
    private let imageForName: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "RectangleName")
        return $0
    }(UIImageView())
    
    private let imageForPosition: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "RectanglePosition")
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [imageForPerson, imageForName, imageForPosition].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            imageForPerson.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageForPerson.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            imageForPerson.heightAnchor.constraint(equalToConstant: 72),
            imageForPerson.widthAnchor.constraint(equalToConstant: 72),
            
            imageForName.leadingAnchor.constraint(equalTo: imageForPerson.trailingAnchor, constant: 16),
            imageForName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            imageForName.heightAnchor.constraint(equalToConstant: 16),
            imageForName.widthAnchor.constraint(equalToConstant: 144),
            
            imageForPosition.leadingAnchor.constraint(equalTo: imageForName.leadingAnchor),
            imageForPosition.topAnchor.constraint(equalTo: imageForName.bottomAnchor, constant: 6),
            imageForPosition.heightAnchor.constraint(equalToConstant: 12),
            imageForPosition.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

}
