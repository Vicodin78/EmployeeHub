//
//  ModelDataFetching.swift
//  KODEtest
//
//  Created by Vicodin on 15.03.2024.
//

import Foundation

// MARK: - ModelType
struct ModelDataFetching: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable, Hashable {
    let id: String
    let avatarURL: String
    let firstName, lastName, userTag, department: String
    let position, phone: String
    var birthday: String

    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatarUrl"
        case firstName, lastName, userTag, department, position, birthday, phone
    }
}

