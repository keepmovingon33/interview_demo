//
//  PostsListViewModel.swift
//  demo
//
//  Created by Sky on 09/12/2021.
//

import Foundation

enum PostsListViewModelLoading {
    case fullScreen
}

protocol PostsListViewModelInput {
    func viewDidLoad()
}

protocol PostsListViewModelOutput {
    var items: Observable<[Car]> { get }
    var loading: Observable<PostsListViewModelLoading?> { get }
    var error: Observable<String> { get }
    var screenTitle: String { get }
    var errorTitle: String { get }
}

protocol PostsListViewModel: PostsListViewModelInput, PostsListViewModelOutput {}

final class DefaultPostsListViewModel: PostsListViewModel {
    private let getPostsUseCase: GetPostsUseCase

    private var postsLoadTask: Cancellable? { willSet { postsLoadTask?.cancel() } }

    // MARK: - OUTPUT

    let items: Observable<[Car]> = Observable([])
    let loading: Observable<PostsListViewModelLoading?> = Observable(.none)
    let error: Observable<String> = Observable("")
    let screenTitle = NSLocalizedString("Demo", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")

    // MARK: - Init

    init(getPostsUseCase: GetPostsUseCase) {
        self.getPostsUseCase = getPostsUseCase
    }

    private func load(loading: PostsListViewModelLoading) {
        self.loading.value = loading

        postsLoadTask = getPostsUseCase.execute(
            completion: { result in
                switch result {
                case .success(let data):
                    self.items.value = data.listings
                case .failure(let error):
                    self.handle(error: error)
                }
                self.loading.value = .none
        })
    }

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading data", comment: "")
    }
}

// MARK: - INPUT. View event methods

extension DefaultPostsListViewModel {

    func viewDidLoad() {
        load(loading: .fullScreen)
    }
}
