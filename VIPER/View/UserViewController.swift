//
//  UserViewController.swift
//  VIPER
//
//  Created by Berkehan on 28.05.2021.
//

import UIKit


protocol UserViewProtocol {
    var presenter : UserPresenterProtocol? {get set}
    func update(with users: [User])
    func update(with error : String)
    
    
}

class UserViewController: UIViewController, UserViewProtocol,UITableViewDelegate,UITableViewDataSource {
    var presenter: UserPresenterProtocol?
    
    private var user: [User] = []
    private let label : UILabel = {
       
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = false
        return label
    }()
 
    private let tableView : UITableView = {
       let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.isHidden = true
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate  = self
        tableView.dataSource = self
        view.backgroundColor = .blue
        view.addSubview(tableView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
    }
    func update(with users: [User]) {
        print(users)
        DispatchQueue.main.async {
            self.user = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
        
    }
    
    func update(with error: String) {
        print("failed ")
        DispatchQueue.main.async {
            self.user = []
            self.tableView.reloadData()
            self.label.isHidden = false
            self.label.text = error
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = user[indexPath.row].name
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    

    
}
