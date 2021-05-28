//
//  UserInteractor.swift
//  VIPER
//
//  Created by Berkehan on 28.05.2021.
//

import Foundation
enum myError : Error {
    case failed
}
protocol UserInteractorProtocol {
    var presenter: UserPresenterProtocol? {get set}
    func getUsers()
    
}

class UserInteractor: UserInteractorProtocol {
    var presenter: UserPresenterProtocol?
    
    func getUsers() {
        guard   let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, err in
            guard let data = data, err == nil else {
                self?.presenter?.interractorDidFetchUsers(with: .failure(myError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interractorDidFetchUsers(with: .success(entities))
            }
            catch {
                self?.presenter?.interractorDidFetchUsers(with: .failure(error))

            }
            
        }
        task.resume()
    }
    
    
}
