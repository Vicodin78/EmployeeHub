//
//  ModelDataForSorting.swift
//  KODEtest
//
//  Created by Vicodin on 16.03.2024.
//

import Foundation

struct SortingData {
    var titlePositionName: [String]
    
    static func makeSortingData() -> SortingData {
        let titleName: [String] = ["По алфавиту", "По дню рождения"]
        let sortingData = SortingData(titlePositionName: titleName)
        return sortingData
    }
}
