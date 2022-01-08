//
//  SearchVideoEntity.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import Foundation

class SearchMovie: Codable{
    var page: Int?
    var results: [DetailMovie]
    var total_results: Int?
    var total_pages: Int?

}

class DetailMovie: Codable{
    var poster_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    var id: Int?
    var original_title: String?
    var original_language: String?
    var title: String?
    var backdrop_path: String?
    var popularity: Decimal?
    var vote_count: Decimal?
    var video: Bool?

}
