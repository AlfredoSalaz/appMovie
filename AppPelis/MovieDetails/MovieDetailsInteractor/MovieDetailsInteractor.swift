//
//  MovieDetailsInteractor.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import UIKit

class MovieDetailsInteractor: NSObject, MovieDetailsInteractorProtocol{
    
    var output: MovieDetailsInteractorOutputProtocol?
    ///Funcion que consulta los detalles de las peliculas
    /// - Parameter id: Contiene el id de la pelicula a consultar
    func getDetailMovies(id: String) {
        RequestManager.generic(url: Constant.urlDetails + "\(id)?api_key=\(Constant.api_key_TMDB)",
                               metodo: .get,
                               tipoResultado: DetailMoview.self ,
                               delegate: self,
                               tag: 0)
    }
    
    ///Funcion que consulta los detalles de los videos de las peliculas
    /// - Parameter id: Contiene el id de la pelicula a consultar
    func getVideoUrlInte(id: String) {
        RequestManager.generic(url: Constant.urlDetails + "\(id)/videos?api_key=\(Constant.api_key_TMDB)",
                               metodo: .get,
                               tipoResultado: DetailVideoUrl.self ,
                               delegate: self,
                               tag: 1
                            )
    }
    
    
}
//MARK: Delegate del Request MANAGER
extension MovieDetailsInteractor: RequestManagerDelegate{
    func onResponseSuccess(data: Decodable?, tag: Int) {
        
        switch tag{
        case 0:
            if let datas = data as? DetailMoview{
                output?.successfulgetData(data: datas)
            }
        case 1:
            if let url = data as? DetailVideoUrl{
                output?.receivedUrlVideo(url: url)
            }

        default:
            print("defaut")
                    }
        
    }
    
    func onResponseFailure(error: CodeResponse, tag: Int) {
        print("Faillure")
    }
}
