//
//  DemoSceneDIContainer.swift
//  demo
//
//  Created by Sky on 09/12/2021.
//

import UIKit
import SwiftUI

final class DemoSceneDIContainer: DemoFlowCoordinatorDependencies {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeGetPostsUseCase() -> GetPostsUseCase {
        return DefaultGetPostsUseCase(postsRepository: makePostsRepository())
    }
    
    // MARK: - Repositories
    func makePostsRepository() -> PostsRepository {
        return DefaultPostsRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    // MARK: - Posts List
    func makePostsListViewController() -> PostsListViewController {
        return PostsListViewController.create(with: makePostsListViewModel())
    }
    
    func makePostsListViewModel() -> PostsListViewModel {
        return DefaultPostsListViewModel(getPostsUseCase: makeGetPostsUseCase())
    }

    // MARK: - Flow Coordinators
    func makeDemoFlowCoordinator(navigationController: UINavigationController) -> DemoFlowCoordinator {
        return DemoFlowCoordinator(navigationController: navigationController,
                                     dependencies: self)
    }
}
