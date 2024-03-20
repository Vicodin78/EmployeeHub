//
//  ProfileViewController.swift
//  KODEtest
//
//  Created by Vicodin on 17.03.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var currentItemPerson: Item?
    
    private let backArrow: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "leftArrowProfile")
        $0.tintColor = UIColor(rgb: 0x050510)
        $0.contentMode = .center
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private let imageForPerson: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 52
        return $0
    }(UIImageView())
    
    private let firstName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Bold", size: 24)
        $0.textColor = UIColor(rgb: 0x050510)
        return $0
    }(UILabel())
    
    private let lastName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Bold", size: 24)
        $0.textColor = UIColor(rgb: 0x050510)
        return $0
    }(UILabel())
    
    private let tagName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Regular", size: 17)
        $0.textColor = UIColor(rgb: 0x97979B)
        return $0
    }(UILabel())
    
    private let positionName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "Inter-Regular", size: 13)
        $0.textColor = UIColor(rgb: 0x55555C)
        return $0
    }(UILabel())
    
    private let backGrView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(rgb: 0xF7F7F8)
        $0.layer.cornerRadius = 16
        return $0
    }(UIView())
    
    private lazy var profileTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        $0.separatorInset = UIEdgeInsets.zero
//        $0.separatorColor = UIColor(rgb: 0xF7F7F8)
        $0.separatorColor = .black
        return $0
    }(UITableView())
    
    private func tapGesturesForBack() {
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        backArrow.addGestureRecognizer(tapGest)
    }
    
    @objc private func tapAction() {
        dismiss(animated: true)
    }
    
    private func callForNumber(_ number: String) {
        let url = URL(string: "tel://\(number)")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func setupVC() {
        guard let tempItem = currentItemPerson else { return }
        imageForPerson.downloaded(from: tempItem.avatarURL, contentMode: .scaleAspectFit)
        firstName.text = tempItem.firstName
        lastName.text = tempItem.lastName
        tagName.text = tempItem.userTag
        positionName.text = tempItem.position
    }
    
    convenience init(item: Item) {
        self.init(nibName:nil, bundle:nil)
        currentItemPerson = item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupVC()
        layout()
        tapGesturesForBack()
    }
    
    private func layout() {
        
        let conteinerView: UIView = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UIView())
        
        [firstName, lastName, tagName].forEach{conteinerView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            firstName.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            firstName.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            firstName.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor),
            
            lastName.leadingAnchor.constraint(equalTo: firstName.trailingAnchor, constant: 8),
            lastName.centerYAnchor.constraint(equalTo: firstName.centerYAnchor),
            
            tagName.leadingAnchor.constraint(equalTo: lastName.trailingAnchor, constant: 8),
            tagName.centerYAnchor.constraint(equalTo: lastName.centerYAnchor),
            tagName.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor)
        ])
        
        [backGrView, backArrow, imageForPerson, conteinerView, positionName, profileTableView].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            backArrow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backArrow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            
            imageForPerson.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageForPerson.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            imageForPerson.heightAnchor.constraint(equalToConstant: 104),
            imageForPerson.widthAnchor.constraint(equalToConstant: 104),
            
            conteinerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conteinerView.topAnchor.constraint(equalTo: imageForPerson.bottomAnchor, constant: 24),
            
            positionName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            positionName.topAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: 12),
            
            backGrView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backGrView.topAnchor.constraint(equalTo: view.topAnchor),
            backGrView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backGrView.bottomAnchor.constraint(equalTo: positionName.bottomAnchor, constant: 24),
            
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileTableView.topAnchor.constraint(equalTo: backGrView.bottomAnchor, constant: 8),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemPerson = currentItemPerson else { return 0 }
        return ModelProfileTableView.makeProfileTableData(person: itemPerson).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        if let itemPerson = currentItemPerson {
            cell.setupCell(data: ModelProfileTableView.makeProfileTableData(person: itemPerson)[indexPath.row], logo: ModelProfileTableView.makeProfileLogoForTableData(person: itemPerson)[indexPath.row])
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let personData = currentItemPerson else { return }
        
        let cell = tableView.cellForRow(at: indexPath) as! ProfileTableViewCell
        if cell.cellTitle.text == personData.phone {
            personData.phone.makeACall()
        }
    }
}
