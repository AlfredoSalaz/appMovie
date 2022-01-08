//
//  ContentPrincipalInteractor.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 06/01/22.
//

import UIKit

class ContentPrincipalInteractor: NSObject, ContentPrincipalInteractorProtocol{
    var output: ContentPrincipalOutputInteractorProtocol?
    ///Funcion que consulta a la API
    func getMovieNowPlaying(){
        RequestManager.generic(url: Constant.urlPlayingNow,
                               metodo: .get,
                               tipoResultado: PlayingNow.self,
                               delegate: self,
                               tag: 0)
    }
    ///Funcion que consulta a la API
    func getMoviewMostPopular(){
        RequestManager.generic(url: Constant.urlMostPopular,
                               metodo: .get,
                               headers: Constant.H.pelis.header(),
                               tipoResultado: PlayingNow.self,
                               delegate: self, tag: 1)
    }
}

extension ContentPrincipalInteractor: RequestManagerDelegate{
    ///Funcionq ue se ejecuta al recibir una respuesta satisfactoria de la API
    /// - Parameter data: informacion recibida
    /// - Parameter tag: Identificador de la consulta
    func onResponseSuccess(data: Decodable?, tag: Int) {
        print("Success")
        switch tag{
        case 0:
            if let data = data as? PlayingNow{
                output?.successfulData(list: data)
            }
        case 1:
            if let data = data as? PlayingNow{
                output?.successFullDataPopular(list: data)
            }
        default:
            break
        }
    }
    ///Funcion que se ejecuta cuando no se realiza de manera satisfactoria la consulta
    /// - Parameter error: contiene el error de la peticion
    /// - Parameter tag: Identidicador de la peticion
    func onResponseFailure(error: CodeResponse, tag: Int) {
        print("Faillure")
    }
}
