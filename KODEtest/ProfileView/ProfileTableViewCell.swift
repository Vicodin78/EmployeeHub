//
//  ProfileTableViewCell.swift
//  KODEtest
//
//  Created by Vicodin on 18.03.2024.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    private let cellLogo: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = UIColor(rgb: 0x050510)
        return $0
    }(UIImageView())
    
    let cellTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Medium", size: 16)
        $0.textColor = UIColor(rgb: 0x050510)
        return $0
    }(UILabel())
    
    private let cellSubTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Medium", size: 16)
        $0.textColor = UIColor(rgb: 0x97979B)
        $0.textAlignment = .right
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
    
    func setupCell(data: String, logo: String) {
        cellLogo.image = UIImage(named: logo)
        setCellTitle(data: data)
        setCellSubTitle(data: data)
    }
    
    private func setCellTitle(data: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: data) {
            formatter.dateFormat = "yyyy"
            let year = formatter.string(from: date)
            formatter.dateFormat = "MM"
            let month = formatter.string(from: date)
            formatter.dateFormat = "dd"
            let day = formatter.string(from: date)
            
            var monthString = String()
            
            switch month {
            case "01":
                monthString = "января"
            case "02":
                monthString = "февраля"
            case "03":
                monthString = "марта"
            case "04":
                monthString = "апреля"
            case "05":
                monthString = "мая"
            case "06":
                monthString = "июня"
            case "07":
                monthString = "июля"
            case "08":
                monthString = "августа"
            case "09":
                monthString = "сентября"
            case "10":
                monthString = "октября"
            case "11":
                monthString = "ноября"
            case "12":
                monthString = "декабря"
            default:
                break
            }
            cellTitle.text = "\(day) \(monthString) \(year)"
        } else {
            cellTitle.text = data
        }
    }
    
    private func setCellSubTitle(data: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: data) else { return }
        
        let now = Date()
        let birthday: Date = date
        let calendar = Calendar.current

        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        
        var agePref = String()
        
        switch age {
        case 1, 21, 31, 41, 51, 61, 71, 81, 91:
            agePref = "год"
        case 2...4, 22...24, 32...34, 42...44, 52...54, 62...64, 72...74, 82...84, 92...94:
            agePref = "года"
        case 5...20, 25...30, 35...40, 45...50, 55...60, 65...70, 75...80, 85...90, 95...100:
            agePref = "лет"
        default:
            agePref = "+"
        }
        cellSubTitle.text = "\(age) \(agePref)"
    }
    
    private func layout() {
        [cellLogo, cellTitle, cellSubTitle].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            cellLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            cellLogo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            
            cellTitle.centerYAnchor.constraint(equalTo: cellLogo.centerYAnchor),
            cellTitle.leadingAnchor.constraint(equalTo: cellLogo.trailingAnchor, constant: 12),
            
            cellSubTitle.centerYAnchor.constraint(equalTo: cellTitle.centerYAnchor),
            cellSubTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
    
}
