//
//  NotFoundTableViewCell.swift
//  KODEtest
//
//  Created by Vicodin on 19.03.2024.
//

import UIKit

class NotFoundTableViewCell: UITableViewCell {

    private let backGrConteinerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let imgView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "find-glass")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let mainTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-SemiBold", size: 17)
        $0.textColor = UIColor(rgb: 0x050510)
        $0.text = "Мы никого не нашли"
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let subTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Regular", size: 16)
        $0.textColor = UIColor(rgb: 0x97979B)
        $0.text = "Попробуй скорректировать запрос"
        $0.textAlignment = .center
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
    
    private func layout() {
        
        [backGrConteinerView, imgView, mainTitle, subTitle].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            backGrConteinerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backGrConteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backGrConteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imgView.centerXAnchor.constraint(equalTo: backGrConteinerView.centerXAnchor),
            imgView.topAnchor.constraint(equalTo: backGrConteinerView.topAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 56),
            imgView.widthAnchor.constraint(equalToConstant: 56),
            
            mainTitle.leadingAnchor.constraint(equalTo: backGrConteinerView.leadingAnchor),
            mainTitle.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 8),
            mainTitle.trailingAnchor.constraint(equalTo: backGrConteinerView.trailingAnchor),
            
            subTitle.leadingAnchor.constraint(equalTo: backGrConteinerView.leadingAnchor),
            subTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 12),
            subTitle.trailingAnchor.constraint(equalTo: backGrConteinerView.trailingAnchor),
            subTitle.bottomAnchor.constraint(equalTo: backGrConteinerView.bottomAnchor)
        ])
    }

}
