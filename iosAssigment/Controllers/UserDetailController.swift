//
//  UserDetailController.swift
//  iosAssigment
//
//  Created by Macbook on 05/06/2024.
//

import UIKit
 
class UserDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    var userLogin: String?
    var viewModel = UserDetailViewModel()
 
    @IBOutlet weak var tableView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        tableView.register(UINib(nibName: "AboutCell", bundle: nil), forCellReuseIdentifier: "AboutCell")
        tableView.register(UINib(nibName: "StatsCell", bundle: nil), forCellReuseIdentifier: "StatsCell")
 
        if let login = userLogin {
            viewModel.loadUserDetails(login: login)
        }
 
        viewModel.onDetailsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
 
    // MARK: - Table view data source
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 // User, About, Stats
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Each section has one row
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
            if let userDetails = viewModel.userDetails {
                cell.loginLabel.text = userDetails.name
                cell.htmlURLLabel.text = userDetails.location
                APIManager.shared.fetchImage(from: userDetails.avatarURL) { result in
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
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as! AboutCell
            cell.bioTextView.text = viewModel.userDetails?.bio
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsCell
            if let userDetails = viewModel.userDetails {
                cell.followersLable.text = "\(String(describing: userDetails.followers!))"
                cell.FollowingLable.text = "\(String(describing: userDetails.following!))"
                cell.publicRepoLable.text = "\(String(describing: userDetails.publicRepos!))"
            }
            return cell
        default:
            fatalError("Unexpected section \(indexPath.section)")
        }
    }
}
