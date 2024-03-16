//
//  MainViewController.swift
//  KODEtest
//
//  Created by Vicodin on 15.03.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    //Регулирует стиль первой ячейки при создании, не дает ячейке снова изменить стиль при пересоздании
    private var observerCollectionCell = 0
    
    //Фиксаторы состояний переключения коллекции департаментов
    private var currentSelected : Int?
    private var previousSelected : IndexPath?
    
    //Временный список персон одного департамента для фильтрации
    var peopleFromDepartment: [Item] = []
    
    //Список департаментов
    var departmentList = [String]()
    
    //Массив полученных данных с полным списком людей
    var tempData: [Item] = []
    
    private let backGrSearchView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(rgb: 0xF7F7F8)
        $0.layer.cornerRadius = 16
        return $0
    }(UIView())
    
    private let imgSearchView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = UIColor(rgb: 0xC3C3C6)
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private lazy var textField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.attributedPlaceholder = NSAttributedString(string: "Введи имя, тег, почту...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xC3C3C6)])
        $0.textAlignment = .left
        $0.font = UIFont(name: "Inter-Medium", size: 15)
        $0.textColor = UIColor(rgb: 0x050510)
        //        $0.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        return $0
    }(UITextField())
    
    private let filterImg: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "list.bullet.indent")
        $0.tintColor = UIColor(rgb: 0xC3C3C6)
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private lazy var collectionViewDepartment: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CollectionViewDepartmentCell.self, forCellWithReuseIdentifier: CollectionViewDepartmentCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private let collectionLineView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(rgb: 0xC3C3C6)
        return $0
    }(UIView())
    
    private lazy var mainTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        $0.separatorColor = .clear
        return $0
    }(UITableView())
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        APIManager.shared.getData { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.tempData = values
                self.departmentList = DepartmentModel.makeDepartmentsList(arrey: self.tempData)
                self.collectionViewDepartment.reloadData()
                self.collectionViewDepartment.layoutIfNeeded()
                self.mainTableView.reloadData()
                self.mainTableView.layoutIfNeeded()
            }
        }
        layout()
    }
    
    private func layout() {
        
        [backGrSearchView, imgSearchView, textField, filterImg, collectionViewDepartment, collectionLineView, mainTableView].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            backGrSearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backGrSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            backGrSearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            imgSearchView.leadingAnchor.constraint(equalTo: backGrSearchView.leadingAnchor, constant: 12),
            imgSearchView.topAnchor.constraint(equalTo: backGrSearchView.topAnchor, constant: 8),
            imgSearchView.bottomAnchor.constraint(equalTo: backGrSearchView.bottomAnchor, constant: -8),
            imgSearchView.widthAnchor.constraint(equalToConstant: 24),
            imgSearchView.heightAnchor.constraint(equalToConstant: 24),
            
            filterImg.topAnchor.constraint(equalTo: backGrSearchView.topAnchor, constant: 8),
            filterImg.trailingAnchor.constraint(equalTo: backGrSearchView.trailingAnchor, constant: -12),
            filterImg.bottomAnchor.constraint(equalTo: backGrSearchView.bottomAnchor, constant: -8),
            filterImg.widthAnchor.constraint(equalToConstant: 24),
            filterImg.heightAnchor.constraint(equalToConstant: 24),
            
            textField.leadingAnchor.constraint(equalTo: imgSearchView.trailingAnchor, constant: 8),
            textField.topAnchor.constraint(equalTo: backGrSearchView.topAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: filterImg.leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: backGrSearchView.bottomAnchor, constant: -8),
            
            collectionViewDepartment.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionViewDepartment.topAnchor.constraint(equalTo: backGrSearchView.bottomAnchor, constant: 14),
            collectionViewDepartment.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionViewDepartment.heightAnchor.constraint(equalToConstant: 32),
            
            collectionLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionLineView.topAnchor.constraint(equalTo: collectionViewDepartment.bottomAnchor),
            collectionLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionLineView.heightAnchor.constraint(equalToConstant: 0.5),
            
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainTableView.topAnchor.constraint(equalTo: collectionLineView.bottomAnchor, constant: 16),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func makeSizeForCell(cell: CollectionViewDepartmentCell, width: CGFloat, height: CGFloat, array: [String], indexPath: IndexPath) -> CGSize {
        cell.frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        cell.setupCell(departmentName: array[indexPath.item])
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size = cell.systemLayoutSizeFitting(CGSize(width: width, height: height), withHorizontalFittingPriority: .defaultLow, verticalFittingPriority: .defaultLow)
        return size
    }
}



//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        departmentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewDepartmentCell.identifier, for: indexPath) as! CollectionViewDepartmentCell
        cell.setupCell(departmentName: departmentList[indexPath.item])
        if currentSelected != nil && currentSelected == indexPath.item {
            // Устанавливает стиль при нажатии на ячейку
            cell.selectCell(size: makeSizeForCell(cell: CollectionViewDepartmentCell(), width: 500, height: 100, array: departmentList, indexPath: indexPath))
        } else {
            // Устанавливает стиль для всех ячеек при создании коллекции
            cell.deselectCell(size: makeSizeForCell(cell: CollectionViewDepartmentCell(), width: 500, height: 100, array: departmentList, indexPath: indexPath))
        }
        if indexPath.item == 0 && observerCollectionCell == 0 {
            // Устанавливает стиль для первой ячейки при создании коллекции
            cell.selectCell(size: makeSizeForCell(cell: CollectionViewDepartmentCell(), width: 500, height: 100, array: departmentList, indexPath: indexPath))
            currentSelected = indexPath.item
            observerCollectionCell += 1
        }
        return cell
    }
    
    
}


//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = makeSizeForCell(cell: CollectionViewDepartmentCell(), width: 500, height: 100, array: departmentList, indexPath: indexPath)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if previousSelected != nil {
            if let cell = collectionView.cellForItem(at: previousSelected!) {
                let secondCell = cell as! CollectionViewDepartmentCell
                // Возвращает стиль ячейкам
                secondCell.deselectCell(size: makeSizeForCell(cell: CollectionViewDepartmentCell(), width: 500, height: 100, array: departmentList, indexPath: previousSelected!))
            }
        }
        if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) {
            let secondCell = cell as! CollectionViewDepartmentCell
            //Устанавливает стиль для первой ячейки после первого деселекта
            secondCell.deselectCell(size: makeSizeForCell(cell: CollectionViewDepartmentCell(), width: 500, height: 100, array: departmentList, indexPath: IndexPath(item: 0, section: 0)))
        }
        currentSelected = indexPath.item
        previousSelected = indexPath
        collectionView.reloadItems(at: [indexPath])
        
        //Часть кода фильтрации по департаменту
        peopleFromDepartment = []
        for i in tempData {
            if i.department == departmentList[indexPath.item] {
                peopleFromDepartment.append(i)
            }
        }
        mainTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !peopleFromDepartment.isEmpty {
            return peopleFromDepartment.count
        } else {
            return tempData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        if !peopleFromDepartment.isEmpty {
            cell.setupCell(item: peopleFromDepartment[indexPath.row])
        } else {
            cell.setupCell(item: tempData[indexPath.row])
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
