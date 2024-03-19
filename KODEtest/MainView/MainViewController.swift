//
//  MainViewController.swift
//  KODEtest
//
//  Created by Vicodin on 15.03.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    //Временное значение вводимое в поле поиска
    private var tempString = String()

    //Регулирует стиль первой ячейки при создании, не дает ячейке снова изменить стиль при пересоздании
    private var observerCollectionCell = 0
    
    //Управляет типом ячеек для отображения
    private var observerTableViewCell = false
    
    //Фиксаторы состояний переключения коллекции департаментов
    private var currentSelected : Int?
    private var previousSelected : IndexPath?
    
    //Список департаментов
    var departmentList = [String]()
    
    //Временный список персон для поиска
    var peopleFromFilter: [Item] = []
    
    //Временный список персон одного департамента
    var peopleFromDepartment: [Item] = []
    
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
        $0.tintColor = UIColor(rgb: 0x6534FF)
        $0.font = UIFont(name: "Inter-Medium", size: 15)
        $0.textColor = UIColor(rgb: 0x050510)
        $0.addTarget(self, action: #selector(endEditionTextField), for: .editingChanged)
        $0.delegate = self
        return $0
    }(UITextField())
    
    private let sortingImg: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "list.bullet.indent")
        if UserSettings.sortMarkerState == 0 {
            $0.tintColor = UIColor(rgb: 0xC3C3C6)
        } else {
            $0.tintColor = UIColor(rgb: 0x6534FF)
        }
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private lazy var cancellButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setAttributedTitle(NSAttributedString(string: "Отмена", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x6534FF), NSAttributedString.Key.font: UIFont(name: "Inter-SemiBold", size: 14) as Any]), for: .normal)
        $0.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
        $0.isHidden = true
        return $0
    }(UIButton())
    
    private var buttonIsHiden = [NSLayoutConstraint]()
    private var buttonNotHiden = [NSLayoutConstraint]()
    
    //MARK: - collectionView
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
    
    
    //MARK: - mainTableView
    private lazy var mainTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        $0.register(PreloadMainTableViewCell.self, forCellReuseIdentifier: PreloadMainTableViewCell.identifier)
        $0.register(NotFoundTableViewCell.self, forCellReuseIdentifier: NotFoundTableViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        $0.separatorColor = .clear
        return $0
    }(UITableView())
    
    private lazy var refreshTableView: UIRefreshControl = {
        $0.tintColor = UIColor(rgb: 0x595F67)
        $0.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return $0
    }(UIRefreshControl())
    
    @objc private func refresh() {
        fetchData()
        refreshTableView.endRefreshing()
    }
    
    private func tapGesturesForView() {
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(tapActionOnSortIcon))
        sortingImg.addGestureRecognizer(tapGest)
    }
    
    @objc private func tapActionOnSortIcon() {
        let vc = SortingViewController()
        vc.delegateSortMarkerState = self
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 20
        }
        present(vc, animated: true)
    }
    
    @objc private func tapOnButton() {
        NSLayoutConstraint.deactivate(buttonNotHiden)
        NSLayoutConstraint.activate(buttonIsHiden)
        UIView.animate(withDuration: 0.35) {
            self.cancellButton.alpha = 0
            self.sortingImg.alpha = 1
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.cancellButton.isHidden = true
            self.sortingImg.isHidden = false
        }
        textField.endEditing(true)
    }
    
    @objc private func endEditionTextField() {
        if let text = textField.text {
            tempString = text
        }
        if !peopleFromDepartment.isEmpty {
            peopleFromFilter = peopleFromDepartment.filter{$0.firstName.lowercased().contains(tempString.lowercased())} + peopleFromDepartment.filter{$0.lastName.lowercased().contains(tempString.lowercased())} + peopleFromDepartment.filter{$0.userTag.lowercased().contains(tempString.lowercased())}
        } else {
            peopleFromFilter =
                tempData.filter{$0.firstName.lowercased().contains(tempString.lowercased())} +
                tempData.filter{$0.lastName.lowercased().contains(tempString.lowercased())} +
                tempData.filter{$0.userTag.lowercased().contains(tempString.lowercased())}
        }
        mainTableView.reloadData()
    }
    
    private func presentCriticalError() {
        let vc = CriticalErrorViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.tapButtondelegate = self
        present(vc, animated: true)
    }
    
    //MARK: - fetchData
    private func fetchData() {
        APIManager.shared.getData { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.tempData = values
                self.departmentList = DepartmentModel.makeDepartmentsList(arrey: self.tempData)
                self.observerTableViewCell = true
                self.collectionViewDepartment.reloadData()
                self.collectionViewDepartment.layoutIfNeeded()
                self.mainTableView.reloadData()
                self.mainTableView.layoutIfNeeded()
            }
        } codeResponse: { [weak self] code in
            DispatchQueue.main.async {
                guard let self else { return }
                if code == 500 {
                    self.presentCriticalError()
                }
            }
        }
        if !Reachability.isConnectedToNetwork() {
            presentCriticalError()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tapGesturesForView()
        layout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchData()
        }
    }
    
    //MARK: - layout
    private func layout() {
        
        buttonIsHiden = [cancellButton.widthAnchor.constraint(equalToConstant: 0)]
        buttonNotHiden = [cancellButton.widthAnchor.constraint(equalToConstant: 78)]
        
        [backGrSearchView, imgSearchView, textField, sortingImg, cancellButton, collectionViewDepartment, collectionLineView, mainTableView].forEach{view.addSubview($0)}
        
        mainTableView.addSubview(refreshTableView)
        
        NSLayoutConstraint.activate(buttonIsHiden)
        
        NSLayoutConstraint.activate([
            backGrSearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            backGrSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            backGrSearchView.trailingAnchor.constraint(equalTo: cancellButton.leadingAnchor),
            
            cancellButton.topAnchor.constraint(equalTo: backGrSearchView.topAnchor),
            cancellButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            cancellButton.bottomAnchor.constraint(equalTo: backGrSearchView.bottomAnchor),
            
            imgSearchView.leadingAnchor.constraint(equalTo: backGrSearchView.leadingAnchor, constant: 12),
            imgSearchView.topAnchor.constraint(equalTo: backGrSearchView.topAnchor, constant: 8),
            imgSearchView.bottomAnchor.constraint(equalTo: backGrSearchView.bottomAnchor, constant: -8),
            imgSearchView.widthAnchor.constraint(equalToConstant: 24),
            imgSearchView.heightAnchor.constraint(equalToConstant: 24),
            
            sortingImg.topAnchor.constraint(equalTo: backGrSearchView.topAnchor, constant: 8),
            sortingImg.trailingAnchor.constraint(equalTo: backGrSearchView.trailingAnchor, constant: -12),
            sortingImg.bottomAnchor.constraint(equalTo: backGrSearchView.bottomAnchor, constant: -8),
            sortingImg.widthAnchor.constraint(equalToConstant: 24),
            sortingImg.heightAnchor.constraint(equalToConstant: 24),
            
            textField.leadingAnchor.constraint(equalTo: imgSearchView.trailingAnchor, constant: 8),
            textField.topAnchor.constraint(equalTo: backGrSearchView.topAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: sortingImg.leadingAnchor),
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
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
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
    func numberOfSections(in tableView: UITableView) -> Int {
        switch observerTableViewCell {
        case false:
            return 10
        case true:
            if !peopleFromFilter.isEmpty {
                return peopleFromFilter.count
            } else {
                if tempString.isEmpty {
                    if !peopleFromDepartment.isEmpty {
                        return peopleFromDepartment.count
                    } else {
                        return tempData.count
                    }
                } else {
                    return 1
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch observerTableViewCell {
        case false:
            let preloadCell = tableView.dequeueReusableCell(withIdentifier: PreloadMainTableViewCell.identifier, for: indexPath) as! PreloadMainTableViewCell
            return preloadCell
        case true:
            if !tempString.isEmpty && peopleFromFilter.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: NotFoundTableViewCell.identifier, for: indexPath) as! NotFoundTableViewCell
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
            if !peopleFromFilter.isEmpty {
                switch UserSettings.sortMarkerState {
                case 0:
                    peopleFromFilter.sort { $0.firstName < $1.firstName }
                    cell.setupCell(item: peopleFromFilter[indexPath.section])
                default:
                    cell.setupCell(item: peopleFromFilter[indexPath.section])
                }
            } else {
                if !peopleFromDepartment.isEmpty {
                    switch UserSettings.sortMarkerState {
                    case 0:
                        peopleFromDepartment.sort { $0.firstName < $1.firstName }
                        cell.setupCell(item: peopleFromDepartment[indexPath.section])
                    default:
                        cell.setupCell(item: peopleFromDepartment[indexPath.section])
                    }
                } else {
                    switch UserSettings.sortMarkerState {
                    case 0:
                        tempData.sort { $0.firstName < $1.firstName }
                        cell.setupCell(item: tempData[indexPath.section])
                    default:
                        cell.setupCell(item: tempData[indexPath.section])
                    }
                }
            }
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch observerTableViewCell {
        case false:
            return 84
        case true:
            if !tempString.isEmpty && peopleFromFilter.isEmpty {
                return 300
            } else {
                return 80
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !peopleFromFilter.isEmpty {
            let vc = ProfileViewController(item: peopleFromFilter[indexPath.section])
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            if !peopleFromDepartment.isEmpty {
                let vc = ProfileViewController(item: peopleFromDepartment[indexPath.section])
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            } else {
                let vc = ProfileViewController(item: tempData[indexPath.section])
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = .white
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        4
    }
}

//MARK: - SortingViewDelegate
extension MainViewController: SortingViewDelegate {
    func sortMarkerStateChange() {
        if UserSettings.sortMarkerState == 0 {
            sortingImg.tintColor = UIColor(rgb: 0xC3C3C6)
        } else {
            sortingImg.tintColor = UIColor(rgb: 0x6534FF)
        }
        observerTableViewCell = false
        mainTableView.reloadData()
        fetchData()
    }
}

//MARK: - CriticalErrorViewDelegate
extension MainViewController: CriticalErrorViewDelegate {
    func tapButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchData()
        }
        dismiss(animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NSLayoutConstraint.deactivate(buttonIsHiden)
        NSLayoutConstraint.activate(buttonNotHiden)
        UIView.animate(withDuration: 0.35) {
            self.cancellButton.alpha = 1
            self.sortingImg.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.cancellButton.isHidden = false
            self.sortingImg.isHidden = true
        }
    }
    
}
