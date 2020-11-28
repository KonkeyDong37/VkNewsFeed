//
//  UserResponse.swift
//  VkNewsFeed
//
//  Created by Андрей on 27.11.2020.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
