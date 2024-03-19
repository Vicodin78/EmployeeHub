//
//  FilterViewController.swift
//  KODEtest
//
//  Created by Vicodin on 16.03.2024.
//

import UIKit

protocol SortingViewDelegate: AnyObject {
    func sortMarkerStateChange()
}

class SortingViewController: UIViewController {
    
    weak var delegateSortMarkerState: SortingViewDelegate?
    
    private let titleName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = UIFont(name: "Inter-SemiBold", size: 20)
        $0.textColor = UIColor(rgb: 0x050510)
        $0.text = "Сортировка"
        return $0
    }(UILabel())
    
    private let backArrow: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "leftArrowForSorting")
//        $0.tintColor = UIColor(rgb: 0x1C1E24)
        $0.contentMode = .center
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private lazy var sortingTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(SortingTableViewCell.self, forCellReuseIdentifier: SortingTableViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        $0.separatorColor = .clear
        return $0
    }(UITableView())
    
    private func tapGesturesForBack() {
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        backArrow.addGestureRecognizer(tapGest)
    }
    
    @objc private func tapAction() {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        tapGesturesForBack()
    }
    
    private func layout() {
        [backArrow, titleName, sortingTableView].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            titleName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            
            backArrow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backArrow.centerYAnchor.constraint(equalTo: titleName.centerYAnchor),
            
            sortingTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            sortingTableView.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: 22.5),
            sortingTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 24),
            sortingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource
extension SortingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SortingData.makeSortingData().titlePositionName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SortingTableViewCell.identifier, for: indexPath) as! SortingTableViewCell
        cell.setupCell(cellTag: indexPath.row, data: SortingData.makeSortingData())
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SortingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserSettings.sortMarkerState = indexPath.row
        self.sortingTableView.reloadData()
        delegateSortMarkerState?.sortMarkerStateChange()
        dismiss(animated: true)
    }
}
