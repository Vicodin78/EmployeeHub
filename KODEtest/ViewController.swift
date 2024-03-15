//
//  ViewController.swift
//  KODEtest
//
//  Created by Vicodin on 15.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var tempData: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
        APIManager.shared.getData { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.tempData = values
            }
        }
    }


}

