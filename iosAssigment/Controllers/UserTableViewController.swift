//
//  ViewController.swift
//  iosAssigment
//
//  Created by Macbook on 04/06/2024.
//


import UIKit


 
class UserTableViewController: UITableViewController{
    
    
    

    
    var viewModel = UserViewModel()
                                        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        viewModel.onUsersUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.loadUsers()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshData() {
        // Thực hiện các hành động cần thiết để làm mới dữ liệu
        viewModel.loadUsers()
        
        // Sau khi hoàn thành việc làm mới dữ liệu, bạn cần dừng refreshControl
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? UserTableViewCell else { return }
        let user = viewModel.users[indexPath.row]

        APIManager.shared.fetchImage(from: user.avatarURL) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    cell.avatarImageView.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        let user = viewModel.users[indexPath.row]
        

        cell.htmlURLLabel.text = user.htmlURL
        
        cell.loginLabel.text = user.login
        
        if cell.avatarImageView.image == nil {
            APIManager.shared.fetchImage(from: user.avatarURL) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        cell.avatarImageView.image = image
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
            
        return cell
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let viewHeight = scrollView.frame.size.height
        if position > contentHeight - viewHeight {
            viewModel.loadMoreData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "UserDetail") as? UserDetailController {
            present(detailVC, animated: true) {
                detailVC.userLogin = user.login
                    detailVC.viewDidLoad()
            }
        
        } else {
            print("Cannot instantiate UserDetailController")
        }
    }
    
    
}
 


