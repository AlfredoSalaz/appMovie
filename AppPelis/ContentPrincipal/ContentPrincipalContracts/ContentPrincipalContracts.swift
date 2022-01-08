//
//  ContentPrincipalContracts.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 06/01/22.
//

import UIKit

//View PROTOCOLS
protocol ContentPrincipalViewControllerProtocol: UIViewController{
    var presenter: ContentPrincipalPresenterProtocol? {get set}
    func successDataPlayingNow(list: PlayingNow)
    func successFulDataPopular(list: PlayingNow)
}
//PRESENTER PROTOCOL
protocol ContentPrincipalPresenterProtocol: NSObject{
    var view: ContentPrincipalViewControllerProtocol? {get set}
    var interactor: ContentPrincipalInteractorProtocol? {get set}
    var router: ContentPrincipalRouterProtocol? {get set}
    
    func getPlayingNow()
    func getMostPopular()
    func getDetailsMovie(string: String)
    func goSearchMovie(text: String)
}
//INTERACTOR PROTOCOL
protocol ContentPrincipalInteractorProtocol: NSObject{
    var output: ContentPrincipalOutputInteractorProtocol? {get set}
    
    func getMovieNowPlaying()
    func getMoviewMostPopular()
}

protocol ContentPrincipalOutputInteractorProtocol: NSObject{
    func successfulData(list: PlayingNow)
    func successFullDataPopular(list: PlayingNow)
}
//ROUTER PROTOCOL
protocol ContentPrincipalRouterProtocol {
    var presenter: ContentPrincipalPresenterProtocol? {get set}
    static func createModule() -> UIViewController
}
