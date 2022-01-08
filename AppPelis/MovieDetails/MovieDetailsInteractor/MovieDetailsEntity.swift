//
//  MovieDetailsEntity.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import Foundation
//MODELO DE DATOS
class DetailMoview: Codable{
    var adult: Bool?
    var backdrop_path: String?
    var budget: Int?
    var genres:[Generes]
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Decimal?
    var poster_path: String?
    var production_companies: [Production_companies]
    var production_countries: [Production_countries]
    var release_date: String?
    var revenue: Int?
    var runtime: Int?
    var spoken_languages: [Spoken_languages]
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Decimal?
    var vote_count: Int?
}

class Generes: Codable{
    var id: Int?
    var name: String?
}

class Production_companies: Codable{
    var id: Int?
    var logo_path: String?
    var name: String?
    var origin_country: String?
}
class Production_countries: Codable{
    var iso_3166_1: String?
    var name: String?
}
class Spoken_languages: Codable{
    var name: String?
    var iso_639_1: String?
    var english_name: String?
}

class DetailVideoUrl: Codable{
    var id: Int?
    var results: [ResultsVideo]
}

class ResultsVideo : Codable{
    var id: String?
    var iso_639_1: String?
    var name: String?
    var key: String?
    var site: String
    var size: Int?
    var type: String?
    var official: Bool?
    var published_at: String?
}
