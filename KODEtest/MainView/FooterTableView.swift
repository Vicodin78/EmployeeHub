//
//  FooterTableView.swift
//  KODEtest
//
//  Created by Vicodin on 21.03.2024.
//

import UIKit

class FooterTableView: UIView {
    
    private let title: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Medium", size: 15)
        $0.textColor = UIColor(rgb: 0xC3C3C6)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let firstLine: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(rgb: 0xC3C3C6)
        return $0
    }(UIView())
    
    private let secondLine: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(rgb: 0xC3C3C6)
        return $0
    }(UIView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeTitle(title: String) {
        self.title.text = title
    }
    
    private func layout() {
        [title, firstLine, secondLine].forEach{addSubview($0)}
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.widthAnchor.constraint(equalToConstant: 160),
            
            firstLine.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            firstLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            firstLine.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -12),
            firstLine.heightAnchor.constraint(equalToConstant: 1),
            
            secondLine.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            secondLine.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 12),
            secondLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            secondLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
