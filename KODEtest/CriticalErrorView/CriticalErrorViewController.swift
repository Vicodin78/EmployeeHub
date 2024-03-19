//
//  CriticalErrorViewController.swift
//  KODEtest
//
//  Created by Vicodin on 19.03.2024.
//

import UIKit

protocol CriticalErrorViewDelegate: AnyObject {
    func tapButton()
}

class CriticalErrorViewController: UIViewController {
    
    weak var tapButtondelegate: CriticalErrorViewDelegate?
    
    private let backGrConteinerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let imgView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "flying-saucer")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let mainTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-SemiBold", size: 17)
        $0.textColor = UIColor(rgb: 0x050510)
        $0.text = "Какой-то сверхразум все сломал"
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let subTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Regular", size: 16)
        $0.textColor = UIColor(rgb: 0x97979B)
        $0.text = "Постараемся быстро починить"
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let buttonTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-SemiBold", size: 16)
        $0.textColor = UIColor(rgb: 0x6534FF)
        $0.text = "Попробовать снова"
        $0.textAlignment = .center
        $0.isUserInteractionEnabled = true
        return $0
    }(UILabel())
    
    private func tapGesturesForView() {
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        buttonTitle.addGestureRecognizer(tapGest)
    }
    
    @objc private func tapAction() {
        tapButtondelegate?.tapButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        tapGesturesForView()
    }
    
    private func layout() {
        
        [backGrConteinerView, imgView, mainTitle, subTitle, buttonTitle].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            backGrConteinerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backGrConteinerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backGrConteinerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
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
            
            buttonTitle.leadingAnchor.constraint(equalTo: backGrConteinerView.leadingAnchor),
            buttonTitle.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 12),
            buttonTitle.trailingAnchor.constraint(equalTo: backGrConteinerView.trailingAnchor),
            buttonTitle.bottomAnchor.constraint(equalTo: backGrConteinerView.bottomAnchor)
        ])
    }
}
