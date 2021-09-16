//
//  AppDIContainer.swift
//  demo
//
//  Created by Sky on 09/12/2021.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    func makeDemoSceneDIContainer() -> DemoSceneDIContainer {
        let dependencies = DemoSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return DemoSceneDIContainer(dependencies: dependencies)
    }
}
