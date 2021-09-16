//
//  DefaultPostsRepository.swift
//  demo
//
//  Created by Sky on 09/12/2021.
//

import Foundation

final class DefaultPostsRepository {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultPostsRepository: PostsRepository {
    public func fetchPostsList(completion: @escaping (Result<CarList, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()

        let endpoint = APIEndpoints.getPosts()
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
