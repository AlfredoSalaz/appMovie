//
//  SearchVideoInteractor.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import Foundation

class SearchVideoInteractor: NSObject, SearchVideoInteractorProtocol{
    
    var output: SearchVideoInteractorOutputProtocol?
    
    func searchMovie(text: String) {
        print("la ul que mando", Constant.searchMovie + "?api_key=\(Constant.api_key_TMDB)&query=\(text)")
        RequestManager.generic(url: Constant.searchMovie + "?api_key=\(Constant.api_key_TMDB)&query=\(text)",
                               metodo: .get,
                               tipoResultado: SearchMovie.self,
                               delegate: self
                               )
    }
    
    
}

extension SearchVideoInteractor: RequestManagerDelegate{
    func onResponseSuccess(data: Decodable?, tag: Int) {
        print("success")
        if let data = data as? SearchMovie{
            output?.onReceivedSuccess(data: data)
        }
    }
    func onResponseFailure(error: CodeResponse, tag: Int) {
        print("faillur")
    }
}
