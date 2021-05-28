//
//  UserPresenter.swift
//  VIPER
//
//  Created by Berkehan on 28.05.2021.
//

import Foundation
// interactor router ve view  referance etmesi lazım 

protocol UserPresenterProtocol {
    var router: UserRouterProtocol? {get set}
    var interactor: UserInteractorProtocol? {get set}
    var view: UserViewProtocol? {get set}
    func interractorDidFetchUsers(with result: Result<[User],Error>)
}
class UserPresenter: UserPresenterProtocol {
  
    var router: UserRouterProtocol?
    
    var interactor: UserInteractorProtocol? {
        didSet{
            interactor?.getUsers()
        }
    }
    
    var view: UserViewProtocol?
    
    func interractorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "smth wrong")
        }
    }
    
    
}
