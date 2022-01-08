//
//  ContentPrincipalPresenter.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 06/01/22.
//

import UIKit

class ContentPrincipalPresenter: NSObject, ContentPrincipalPresenterProtocol{
    
    weak var view: ContentPrincipalViewControllerProtocol?
    var interactor: ContentPrincipalInteractorProtocol?
    var router: ContentPrincipalRouterProtocol?
    ///Funcion que llama al interactor para obtener la info de Playing now
    func getPlayingNow() {
        interactor?.getMovieNowPlaying()
    }
    ///Funcion que llama al interactor para obtener la info de peliculas populares
    func getMostPopular() {
        interactor?.getMoviewMostPopular()
    }
    ///Funcion que abre la vista de los detalles de las peliculas
    /// - Parameter string: COntiene el id de la tarifa
    func getDetailsMovie(string: String) {
        let viewController = MovieDetailsRouter.createModule(id: string)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    ///Funcion que abre la vista de los resultados de la busqueda
    /// - Parameter string: COntiene la cadena de caracteres a consultar
    func goSearchMovie(text: String) {
        let viewController = SearchVideoRouter.createModulo(text: text)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    

}
//MARK: Extension de respuestas del WS
extension ContentPrincipalPresenter: ContentPrincipalOutputInteractorProtocol{
    ///Funcion que recibe de manera exitosa la lista de las Playing now
    /// - Parameter list: Lista de elementos recibidos
    func successfulData(list: PlayingNow) {
        view?.successDataPlayingNow(list: list)
    }
    //Funcion que recibe de manera exitosa la lista de las peliculas populares
    /// - Parameter list: Lista de elementos recibidos
    func successFullDataPopular(list: PlayingNow) {
        view?.successFulDataPopular(list: list)
    }
    
}
