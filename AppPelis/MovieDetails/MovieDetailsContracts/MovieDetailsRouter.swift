//
//  MovieDetailsRouter.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import UIKit

class MovieDetailsRouter: MovieDetailsRouterProtocol{
    var presenter: MovieDetailsPresenterProtocol?
    
    static func createModule(id:String) -> UIViewController {
        let main = mainStoryBoard
        let view = main.instantiateViewController(withIdentifier: "MovieDetails") as! MovieDetailsViewControllerProtocol
        let presenter: MovieDetailsPresenterProtocol &  MovieDetailsInteractorOutputProtocol = MovieDetailsPresenter()
        let interactor: MovieDetailsInteractorProtocol = MovieDetailsInteractor()
        var router: MovieDetailsRouterProtocol = MovieDetailsRouter()
        
        view.presenter = presenter
        view.id = id
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.presenter = presenter
        
        return view
    }
    static var mainStoryBoard: UIStoryboard{
        return UIStoryboard(name: "MovieDetailsStoryboard", bundle: nil)
    }
}

