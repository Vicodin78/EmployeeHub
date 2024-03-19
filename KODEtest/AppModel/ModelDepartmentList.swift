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
        
        
//        var tempName = Set<String>()
//        for i in arrey {
//            tempName.insert(i.department)
//        }
//        var tempArrey = [String]()
//        for i in tempName {
//            tempArrey.append(i)
//        }
//        var departmentName = [String: String]()
//        for i in tempArrey {
//            switch i {
//            case "android":
//                departmentName.updateValue("Android", forKey: "android")
//                tempName.remove("android")
//            case "ios":
//                departmentName.updateValue("iOS", forKey: "ios")
//                tempName.remove("ios")
//            case "design":
//                departmentName.updateValue("Дизайн", forKey: "design")
//                tempName.remove("design")
//            case "management":
//                departmentName.updateValue("Менеджмент", forKey: "management")
//                tempName.remove("management")
//            case "qa":
//                departmentName.updateValue("QA", forKey: "qa")
//                tempName.remove("qa")
//            case "back_office":
//                departmentName.updateValue("Бэк-офис", forKey: "back_office")
//                tempName.remove("back_office")
//            case "frontend":
//                departmentName.updateValue("Frontend", forKey: "frontend")
//                tempName.remove("frontend")
//            case "hr":
//                departmentName.updateValue("HR", forKey: "hr")
//                tempName.remove("hr")
//            case "pr":
//                departmentName.updateValue("PR", forKey: "pr")
//                tempName.remove("pr")
//            case "backend":
//                departmentName.updateValue("Backend", forKey: "backend")
//                tempName.remove("backend")
//            case "support":
//                departmentName.updateValue("Техподдержка", forKey: "support")
//                tempName.remove("support")
//            case "analytics":
//                departmentName.updateValue("Аналитика", forKey: "analytics")
//                tempName.remove("analytics")
//            default:
//                departmentName.updateValue("Прочие", forKey: tempName.first ?? "others")
//                tempName.removeFirst()
//            }
//        }
//        departmentName.updateValue("Все", forKey: "all")
//        print(departmentName)
//        return departmentName
    }
}
