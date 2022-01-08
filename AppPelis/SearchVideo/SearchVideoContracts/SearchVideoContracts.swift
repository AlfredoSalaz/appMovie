//
//  SearchVideoContracts.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import Foundation
import UIKit

protocol SearchVideoViewControllerProtocol: UIViewController{
    var presenter: SearchVideoPresenterProtocol? {get set}
    var text: String? {get set}
    func onSetDataView(data: SearchMovie)
}

protocol SearchVideoPresenterProtocol: NSObject{
    var view: SearchVideoViewControllerProtocol? {get set}
    var interactor: SearchVideoInteractorProtocol? {get set}
    var router: SearchVideoRouterProtocol? {get set}
    
    func searchMovies(text: String)
    func goDetailMovie(id: String)
}

protocol SearchVideoInteractorProtocol: NSObject{
    var output: SearchVideoInteractorOutputProtocol? {get set}
    func searchMovie(text: String)
}

protocol SearchVideoInteractorOutputProtocol: NSObject{
    func onReceivedSuccess(data: SearchMovie)
    func onFaillure()
}

protocol SearchVideoRouterProtocol{
    var presenter:  SearchVideoPresenterProtocol? {get set}
    static func createModulo(text: String) -> UIViewController
}

