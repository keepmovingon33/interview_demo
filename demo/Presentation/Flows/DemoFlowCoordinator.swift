//
//  DemoFlowCoordinator.swift
//  demo
//
//  Created by Sky on 09/12/2021.
//

import UIKit

protocol DemoFlowCoordinatorDependencies  {
    func makePostsListViewController() -> PostsListViewController
}

final class DemoFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: DemoFlowCoordinatorDependencies

    private weak var postsListVC: PostsListViewController?

    init(navigationController: UINavigationController,
         dependencies: DemoFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makePostsListViewController()

        navigationController?.pushViewController(vc, animated: false)
        postsListVC = vc
    }
}
