//
//  APIManager.swift
//  iosAssigment
//
//  Created by Macbook on 04/06/2024.
//


import Alamofire
import AlamofireImage
import Foundation
import UIKit
 
class APIManager {
    static let shared = APIManager() // Singleton instance
    private let baseURL = "https://api.github.com/users"
    private let decoder = JSONDecoder()
 
    // Fetch a list of users
    func fetchUsers(page: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        let url = "\(baseURL)?per_page=\(page*30)"
        AF.request(url, method: .get).validate().responseDecodable(of: [User].self) { response in
            switch response.result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
 
    // Fetch user details by login
    func fetchUserDetail(by login: String, completion: @escaping (Result<UserDetail, Error>) -> Void) {
        let url = "\(baseURL)/\(login)"
        AF.request(url, method: .get).validate().responseDecodable(of: UserDetail.self) { response in
            switch response.result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchImage(from link: String?, completion: @escaping (Result<UIImage, Error>) -> Void) {
                // Sử dụng AlamofireImage để tải hình ảnh từ đường dẫn
                if let link = link {
                    AF.request(link).responseImage { response in
                        switch response.result {
                        case .success(let image):
                            // Truyền hình ảnh thông qua completion handler nếu tải thành công
                            completion(.success(image))
                        case .failure(let error):
                            // Truyền lỗi thông qua completion handler nếu có vấn đề xảy ra
                            completion(.failure(error))
                        }
                    }
                }
            }
    
    
}







