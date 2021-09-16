//
//  PostsRepository.swift
//  demo
//
//  Created by Sky on 09/12/2021.
//

import Foundation

protocol PostsRepository {
    @discardableResult
    func fetchPostsList(completion: @escaping (Result<CarList, Error>) -> Void) -> Cancellable?
}
