//
//  Constant.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 06/01/22.
//

import Foundation

class Constant{
    
    static let urlPlayingNow = "https://api.themoviedb.org/3/movie/now_playing?api_key=d2fe4ef3c98e7a9a244c85cb6ba825e3"
    static let urlMostPopular = "https://api.themoviedb.org/3/movie/popular?api_key=d2fe4ef3c98e7a9a244c85cb6ba825e3"
    static let urlImage = "https://image.tmdb.org/t/p/original"
    static let urlYoutube = "https://www.youtube.com/watch?v="
    static let urlDetails = "https://api.themoviedb.org/3/movie/"
    static let searchMovie = "https://api.themoviedb.org/3/search/movie"
    
    ///Authorization Conozco mi consumo
    static var api_key_TMDB: String{
        get { "d2fe4ef3c98e7a9a244c85cb6ba825e3" }
    }
    enum H {
        case Empty
        case pelis
        func header(_ extra:[String:String]? = nil) -> [String:String]? {
            switch self {
            case .Empty:
                return extra
            case .pelis:
                return ["api_key" : Constant.api_key_TMDB] + extra
            }
            
            
        }
    }
}

func + <K, V> (left: [K:V], right: [K:V]?) -> [K:V] {
    guard let right = right else { return left }
    var r:[K:V] = left
    for (k, v) in right {
        r[k] = v
    }
    return r
}
