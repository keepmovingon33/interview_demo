//
//  APIEndpoints.swift
//  demo
//
//  Created by Sky on 09/12/2021.
//

import Foundation

struct APIEndpoints {
    static func getPosts() -> Endpoint<DemoResponseDTO> {

        return Endpoint(path: "", method: .get)
    }
}
