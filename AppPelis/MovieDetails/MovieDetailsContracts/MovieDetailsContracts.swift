//
//  MovieDetailsContracts.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import UIKit


protocol MovieDetailsViewControllerProtocol: UIViewController{
    var presenter: MovieDetailsPresenterProtocol? {get set}
    var id : String? { get set }
    func getSuccessData(data: DetailMoview)
    func loadUrlVideo(url: DetailVideoUrl)
}

protocol MovieDetailsPresenterProtocol: NSObject{
    var view: MovieDetailsViewControllerProtocol? {get set}
    var interactor: MovieDetailsInteractorProtocol? {get set}
    var router: MovieDetailsRouterProtocol? {get set}
    
    func getDetailMovie(id: String)
    func getVideoUrl(id: String)
}

protocol MovieDetailsInteractorProtocol: NSObject{
    var output: MovieDetailsInteractorOutputProtocol? {get set}
    func getDetailMovies(id: String)
    func getVideoUrlInte(id: String)
}

protocol MovieDetailsInteractorOutputProtocol: NSObject{
    func successfulgetData(data: DetailMoview)
    func receivedUrlVideo(url: DetailVideoUrl)
    func failluregetData()
}

protocol MovieDetailsRouterProtocol {
    var presenter: MovieDetailsPresenterProtocol? {get set}
    
    static func createModule(id: String) -> UIViewController
}
