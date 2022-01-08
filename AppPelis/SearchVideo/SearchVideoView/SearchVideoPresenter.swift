//
//  SearchVideoPresenter.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import Foundation

class SearchVideoPresenter: NSObject, SearchVideoPresenterProtocol{
    
    var view: SearchVideoViewControllerProtocol?
    var interactor: SearchVideoInteractorProtocol?
    var router: SearchVideoRouterProtocol?
    
    
    func searchMovies(text: String) {
        interactor?.searchMovie(text: text)
    }
    
    func goDetailMovie(id: String) {
        let viewController = MovieDetailsRouter.createModule(id: id)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

extension SearchVideoPresenter: SearchVideoInteractorOutputProtocol{
    func onReceivedSuccess(data: SearchMovie) {
        view?.onSetDataView(data: data)
    }
    
    func onFaillure() {
        
    }
    
    
}
