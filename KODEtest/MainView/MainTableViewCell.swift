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
    
    private let birthday: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Regular", size: 15)
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
        switch UserSettings.sortMarkerState {
        case 1:
            setBirthdayDate(data: item.birthday)
        default:
            birthday.text = ""
        }
    }
    
    private func setBirthdayDate(data: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: data) {
            formatter.dateFormat = "MM"
            let month = formatter.string(from: date)
            formatter.dateFormat = "dd"
            let day = formatter.string(from: date)
            
            var monthString = String()
            
            switch month {
            case "01":
                monthString = "янв"
            case "02":
                monthString = "фев"
            case "03":
                monthString = "маh"
            case "04":
                monthString = "апр"
            case "05":
                monthString = "мая"
            case "06":
                monthString = "июн"
            case "07":
                monthString = "июл"
            case "08":
                monthString = "авг"
            case "09":
                monthString = "сен"
            case "10":
                monthString = "окт"
            case "11":
                monthString = "ноя"
            case "12":
                monthString = "дек"
            default:
                break
            }
            birthday.text = "\(day) \(monthString)"
        }
    }
    
    private func layout() {
        [imageForPerson, firstName, lastName, tagName, positionName, birthday].forEach{contentView.addSubview($0)}
        
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
            positionName.topAnchor.constraint(equalTo: firstName.bottomAnchor, constant: 3),
            
            birthday.centerYAnchor.constraint(equalTo: firstName.bottomAnchor),
            birthday.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
}
