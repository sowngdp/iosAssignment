//
//  User.swift
//  iosAssigment
//
//  Created by Macbook on 04/06/2024.
//

import Foundation
 
struct User: Decodable {
    let id: Int
    let login: String
    let avatarURL: String
    let htmlURL: String
 
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }
}
 
struct UserDetail: Decodable {
    let id: Int64
    let avatarURL: String
    let login: String
    let name: String
    let location: String?
    let bio: String?
    let publicRepos: Int64?
    let followers: Int64?
    let following: Int64?
 
    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL =  "avatar_url"
        case login
        case name
        case location
        case bio
        case publicRepos = "public_repos"
        case followers
        case following
    }
}


