//
//  ErrorEntity.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 06/01/22.
//

import Foundation

class ErrorEntity: Codable {
    var code: Int?
    var type: String?
    var message: String?
}
