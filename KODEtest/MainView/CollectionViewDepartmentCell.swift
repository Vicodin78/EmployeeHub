//
//  collectionViewDepartmentCellCollectionViewCell.swift
//  KODEtest
//
//  Created by Vicodin on 15.03.2024.
//

import UIKit

class CollectionViewDepartmentCell: UICollectionViewCell {
    
    private let titleCell: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = UIFont(name: "Inter-SemiBold", size: 15)
        $0.textColor = UIColor(rgb: 0x97979B)
        return $0
    }(UILabel())
    
    private let lineForCell: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(rgb: 0x6534FF)
        $0.isHidden = true
        return $0
    }(UIView())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        layout()
    }
    
    func setupCell(departmentName: String) {
        
        switch departmentName {
        case "all":
            titleCell.text = "Все"
        case "android":
            titleCell.text = "Android"
        case "ios":
            titleCell.text = "iOS"
        case "design":
            titleCell.text = "Дизайн"
        case "management":
            titleCell.text = "Менеджмент"
        case "qa":
            titleCell.text = "QA"
        case "back_office":
            titleCell.text = "Бэк-офис"
        case "frontend":
            titleCell.text = "Frontend"
        case "hr":
            titleCell.text = "HR"
        case "pr":
            titleCell.text = "PR"
        case "backend":
            titleCell.text = "Backend"
        case "support":
            titleCell.text = "Техподдержка"
        case "analytics":
            titleCell.text = "Аналитика"
        default:
            titleCell.text = "Прочие"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectCell(size: CGSize) {
        self.titleCell.font = UIFont(name: "Inter-SemiBold", size: 15)
        self.titleCell.textColor = UIColor(rgb: 0x050510)
        self.lineForCell.isHidden = false
        self.layout()
    }
    
    func deselectCell(size: CGSize) {

        self.titleCell.font = UIFont(name: "Inter-Medium", size: 15)
        self.titleCell.textColor = UIColor(rgb: 0x97979B)
        self.lineForCell.isHidden = true
    }
    
    private func layout() {
        
        [titleCell, lineForCell].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            titleCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            lineForCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineForCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineForCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineForCell.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
}
