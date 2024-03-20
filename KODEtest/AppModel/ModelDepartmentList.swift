//
//  ModelDepartmentList.swift
//  KODEtest
//
//  Created by Vicodin on 15.03.2024.
//

import Foundation

class DepartmentModel {
    
    static func makeDepartmentsList(arrey: [Item]) -> [String] {
        
        var tempName = Set<String>()
        for i in arrey {
            tempName.insert(i.department)
        }
        var departmentName = [String]()
        for i in tempName {
            departmentName.append(i)
        }
        departmentName.sort()
        departmentName.insert("all", at: 0)
        return departmentName
    }
}
