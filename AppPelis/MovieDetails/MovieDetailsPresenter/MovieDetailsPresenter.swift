//
//  MovieDetailsPresenter.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import Foundation

class MovieDetailsPresenter: NSObject, MovieDetailsPresenterProtocol{
    
    var view: MovieDetailsViewControllerProtocol?
    var interactor: MovieDetailsInteractorProtocol?
    var router: MovieDetailsRouterProtocol?
    ///Funcion que consulta a la api los detalles de las peliculas
    /// - Parameter string: COntiene el id de la pelicula
    func getDetailMovie(id: String) {
        interactor?.getDetailMovies(id: id)
    }
    ///Funcion que consulta a la api los detalles de la url del video
    /// - Parameter string: COntiene el id de la pelicula
    func getVideoUrl(id: String) {
        interactor?.getVideoUrlInte(id: id)
    }
    
    
}
//MARK: Delegado del Interactor output
extension MovieDetailsPresenter: MovieDetailsInteractorOutputProtocol{
    ///Funcion que se ejecuta cuando se obtuvo una respuesta exitosa por parte de la api
    /// - Parameter url: COntiene los detalles de la url del viep
    func receivedUrlVideo(url: DetailVideoUrl) {
        view?.loadUrlVideo(url: url)
    }
    ///Funcion que se ejecuta cuando se obtuvo una respuesta exitosa por parte de la api
    /// - Parameter url: COntiene los detalles de la pelicula
    func successfulgetData(data: DetailMoview) {
        view?.getSuccessData(data: data)
    }
    
    
    func failluregetData() {
        
    }
    
    
}
