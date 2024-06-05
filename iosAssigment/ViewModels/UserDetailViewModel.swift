//
//  UserDetailViewModel.swift
//  iosAssigment
//
//  Created by Macbook on 04/06/2024.
//

import Foundation


class UserDetailViewModel {
    public var userDetails: UserDetail?
    var onDetailsUpdated: (() -> Void)?
 
    func loadUserDetails(login: String) {
        APIManager.shared.fetchUserDetail(by: login) { [weak self] result in
            switch result {
            case .success(let details):
                self?.userDetails = details
                self?.onDetailsUpdated?()
            case .failure(let error):
                print(error) // Handle the error appropriately
            }
        }
    }
}


