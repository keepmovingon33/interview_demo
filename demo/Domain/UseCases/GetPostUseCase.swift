//
//  GetPostUseCase.swift
//  demo
//
//  Created by Sky on 09/12/2021.
//

import Foundation

protocol GetPostsUseCase {
    func execute(completion: @escaping (Result<CarList, Error>) -> Void) -> Cancellable?
}

final class DefaultGetPostsUseCase: GetPostsUseCase {

    private let postsRepository: PostsRepository

    init(postsRepository: PostsRepository) {
        self.postsRepository = postsRepository
    }

    func execute(completion: @escaping (Result<CarList, Error>) -> Void) -> Cancellable? {
        return postsRepository.fetchPostsList(completion: { result in
            completion(result)
        })
    }
}
