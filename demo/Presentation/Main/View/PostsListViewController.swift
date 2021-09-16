//
//  PostsListViewController.swift
//  demo
//
//  Created by Sky on 09/12/2021.
//

import UIKit

class PostsListViewController: UIViewController, Alertable {
    private var tableView: UITableView!
    
    private var viewModel: PostsListViewModel!
    
    static func create(with viewModel: PostsListViewModel) -> PostsListViewController {
        let view = PostsListViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: PostsListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        viewModel.loading.observe(on: self) { [weak self] in
            guard let self = self else { return }
            self.updateLoading($0)
        }
        
        viewModel.error.observe(on: self) { [weak self] in
            guard let self = self else { return }
            self.showError($0)
        }
    }
    
    private func setupViews() {
        title = viewModel.screenTitle
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ItemTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ItemTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        self.view.addSubview(tableView)
    }
    
    private func updateLoading(_ loading: PostsListViewModelLoading?) {
        switch loading {
        case .fullScreen:
            LoadingView.show()
        case .none:
            LoadingView.hide()
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }
}

extension PostsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier, for: indexPath) as? ItemTableViewCell else {
            assertionFailure("Cannot dequeue reusable cell \(ItemTableViewCell.self) with reuseIdentifier: \(ItemTableViewCell.reuseIdentifier)")
            return UITableViewCell()
        }

        cell.config(with: viewModel.items.value[indexPath.row])

        return cell
    }
}
