//
//  UserListViewModel\.swift
//  iosAssigment
//
//  Created by Macbook on 04/06/2024.
//

import Foundation
 

class UserViewModel {
    public var users: [User] = []
    var onUsersUpdated: (() -> Void)?
    private var currentPage = 1
    private var isLoadingData = false
 
    func loadUsers() {
        loadUsers(page: 1)
    }

    private func loadUsers(page: Int) {
        guard !isLoadingData else { return }
        isLoadingData = true
        currentPage = page

        APIManager.shared.fetchUsers(page: page) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingData = false

                switch result {
                case .success(let users):
                    self?.users = users
                    self?.onUsersUpdated?()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    func loadMoreData() {
        loadUsers(page: currentPage + 1)
    }
    
}
