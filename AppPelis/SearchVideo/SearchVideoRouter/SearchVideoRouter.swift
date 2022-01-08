//
//  SearchVideoRouter.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import Foundation
import UIKit

class SearchVideoRouter: SearchVideoRouterProtocol{
    var presenter: SearchVideoPresenterProtocol?
    
    static func createModulo(text: String) -> UIViewController {
        let main = mainStoryBoard
        let view = main.instantiateViewController(withIdentifier: "SearchVideo") as! SearchVideoViewControllerProtocol
        let presenter: SearchVideoPresenterProtocol & SearchVideoInteractorOutputProtocol = SearchVideoPresenter()
        let interactor: SearchVideoInteractorProtocol = SearchVideoInteractor()
        var router: SearchVideoRouterProtocol = SearchVideoRouter()
        
        
        view.presenter = presenter
        view.text = text
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.presenter = presenter
        
        
        return view
    }
    
    
    
    static var mainStoryBoard: UIStoryboard{
        return UIStoryboard(name: "SearchVideoStoryboard", bundle: nil)
    }}
