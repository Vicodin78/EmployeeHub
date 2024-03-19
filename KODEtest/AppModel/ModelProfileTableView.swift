//
//  ModelProfileTableView.swift
//  KODEtest
//
//  Created by Vicodin on 18.03.2024.
//

import Foundation

class ModelProfileTableView {
    
    static func makeProfileTableData(person: Item) -> [String] {
        
        var tempArrey = [String]()
        tempArrey.append(person.birthday)
        tempArrey.append(person.phone)
    
        return tempArrey
 
    }
    
    static func makeProfileLogoForTableData(person: Item) -> [String] {
        
        var tempArrey = [String]()
        tempArrey.append("birthdayLogo")
        tempArrey.append("phoneLogo")
    
        return tempArrey
 
    }
}
