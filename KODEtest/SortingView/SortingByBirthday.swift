//
//  SortingByBirthday.swift
//  KODEtest
//
//  Created by Vicodin on 20.03.2024.
//

import UIKit

class SortingByBirthday {
    
    static let sort = SortingByBirthday()
    
    func makeSortByBirthday(items: [Item]) -> [[Item]] {
        var tempArrey = items
        
        var firstTempArrey = [Item]()
        var secondTempArrey = [Item]()
        
        let formatterForNow = DateFormatter()
        formatterForNow.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let formatterForItem = DateFormatter()
        formatterForItem.dateFormat = "yyyy-MM-dd"
        
        //Текущие даты
        let now = Date()
        let calendar = Calendar.current
        
        //Текущий год
        var currentYear = String()
        
        //Вычисляем текущий год
        if let date = formatterForNow.date(from: "\(now)") {
            formatterForNow.dateFormat = "yyyy"
            let year = formatterForNow.string(from: date)
            currentYear = year
        }
        
        for (index, value) in items.enumerated() {
            //Вычисляем месяц и день рождения, создаем массив с днями рождения в этом году
            formatterForItem.dateFormat = "yyyy-MM-dd"
            if let date = formatterForItem.date(from: value.birthday) {
                formatterForItem.dateFormat = "MM"
                let month = formatterForItem.string(from: date)
                formatterForItem.dateFormat = "dd"
                let day = formatterForItem.string(from: date)
                
                tempArrey[index].birthday = "\(currentYear)-\(month)-\(day)"
            }
        }
        
        var tempSortedDict: [Int: Item] = [:]
        //Подготавливаем словарь для сортировки людей по будущим дням рождения
        for (index, value) in tempArrey.enumerated() {
            formatterForItem.dateFormat = "yyyy-MM-dd"
            if let date = formatterForItem.date(from: value.birthday) {
                let birthday: Date = date
                let ageComponents = calendar.dateComponents([.day], from: now, to: birthday)
                tempSortedDict.updateValue(items[index], forKey: ageComponents.day!)
            }
        }
        
        //Распределяем людей на два массива: др после текущего дня и др в будущем году
        for (key, value) in tempSortedDict.sorted(by: { $0.0 < $1.0 }) {
            if key >= 0 {
                firstTempArrey.append(value)
            } else {
                secondTempArrey.append(value)
            }
        }
        return [firstTempArrey, secondTempArrey]
    }
}
