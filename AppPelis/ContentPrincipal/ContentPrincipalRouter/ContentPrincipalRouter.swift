//
//  ContentPrincipalRouter.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 06/01/22.
//

import Foundation
import UIKit

class ContentPrincipalRouter: ContentPrincipalRouterProtocol{
    var presenter: ContentPrincipalPresenterProtocol?
    ///Funcion que inicializa la vista y las variables
    static func createModule() -> UIViewController {
        let main = mainStoryBoard
        let view = main.instantiateViewController(withIdentifier: "contentPrincipal") as! ContentPrincipalViewControllerProtocol
        let presenter: ContentPrincipalPresenterProtocol & ContentPrincipalOutputInteractorProtocol = ContentPrincipalPresenter()
        let interactor: ContentPrincipalInteractorProtocol = ContentPrincipalInteractor()
        var router:  ContentPrincipalRouterProtocol = ContentPrincipalRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    
    static var mainStoryBoard: UIStoryboard{
        return UIStoryboard(name: "ContentPrincipalStoryboard", bundle: nil)
    }

}
