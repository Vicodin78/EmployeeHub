//
//  MainTableViewCell.swift
//  KODEtest
//
//  Created by Vicodin on 16.03.2024.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    private let imageForPerson: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.image = UIImage(named: "goose")
        $0.layer.cornerRadius = 36
        return $0
    }(UIImageView())
    
    private let firstName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Medium", size: 16)
        $0.textColor = UIColor(rgb: 0x050510)
        return $0
    }(UILabel())
    
    private let lastName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Medium", size: 16)
        $0.textColor = UIColor(rgb: 0x050510)
        return $0
    }(UILabel())
    
    private let tagName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Medium", size: 14)
        $0.textColor = UIColor(rgb: 0x97979B)
        return $0
    }(UILabel())
    
    private let positionName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Regular", size: 13)
        $0.textColor = UIColor(rgb: 0x55555C)
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
    
    func setupCell(item: Item) {
        imageForPerson.downloaded(from: item.avatarURL, contentMode: .scaleAspectFit)
        firstName.text = item.firstName
        lastName.text = item.lastName
        tagName.text = item.userTag
        positionName.text = item.position
    }
    
    private func layout() {
        [imageForPerson, firstName, lastName, tagName, positionName].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            imageForPerson.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageForPerson.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            imageForPerson.heightAnchor.constraint(equalToConstant: 72),
            imageForPerson.widthAnchor.constraint(equalToConstant: 72),
            
            firstName.leadingAnchor.constraint(equalTo: imageForPerson.trailingAnchor, constant: 16),
            firstName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            
            lastName.leadingAnchor.constraint(equalTo: firstName.trailingAnchor, constant: 6),
            lastName.topAnchor.constraint(equalTo: firstName.topAnchor),
            
            tagName.leadingAnchor.constraint(equalTo: lastName.trailingAnchor, constant: 4),
            tagName.bottomAnchor.constraint(equalTo: lastName.bottomAnchor),
            
            positionName.leadingAnchor.constraint(equalTo: firstName.leadingAnchor),
            positionName.topAnchor.constraint(equalTo: firstName.bottomAnchor, constant: 3)
        ])
    }
}
