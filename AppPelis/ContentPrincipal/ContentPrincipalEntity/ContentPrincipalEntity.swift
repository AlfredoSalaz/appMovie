//
//  ContentPrincipalEntity.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 06/01/22.
//

import Foundation

//MODELO DE DATOS
class PlayingNow: Codable{
    var dates: Dates?
    var page: Int?
    var results: [Results]
    var total_pages: Int?
    var total_results: Int?
}

class Dates: Codable{
    var maximum: String?
    var minimum: String?
}

class Results: Codable{
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
}

