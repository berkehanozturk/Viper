//
//  UserRouter.swift
//  VIPER
//
//  Created by Berkehan on 28.05.2021.
//

import UIKit
//

typealias EntryPoint = UserViewProtocol & UIViewController
protocol UserRouterProtocol {
    var entry: EntryPoint? {get set}
    static func start() -> UserRouterProtocol
}

class UserRouter: UserRouterProtocol {
    
    var entry: EntryPoint?
    static func start() -> UserRouterProtocol {
        let router = UserRouter()
        
        //assign VIP
        var view: UserViewProtocol = UserViewController()
        var presenter: UserPresenterProtocol = UserPresenter()
        var interactor: UserInteractorProtocol = UserInteractor()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        router.entry = view as? EntryPoint
        return router
    }
    
    
}
