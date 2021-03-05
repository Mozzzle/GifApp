//
//  ViewController.swift
//  Gifs App
//
//  Created by Slava Kuzmitsky on 02.03.2021.
//  Copyright © 2021 Slava Kuzmitsky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBar: UISearchBar { return searchController.searchBar }
    
    private var gifViewModel: ViewModel?
    private let api = APIProvider()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: StaticConstant.nibName , bundle: nil), forCellReuseIdentifier: StaticConstant.cellIdentifier )
    
        configureSearchController()
        fetchData()
    }
    
    private func fetchData() {
        gifViewModel = ViewModel(apiProvider: api)
        if let viewModel = gifViewModel {
            viewModel.data.drive(tableView.rx.items(cellIdentifier: StaticConstant.cellIdentifier)) {_, gif, cell in
                let cell = cell as! GifCell
                guard let url = URL(string: gif.url) else { return }
                cell.configureCell(image: ZGIFImage.image(url: url))
                }.disposed(by: disposeBag)
            searchBar.rx.text
                .orEmpty
                .bind(to: viewModel.searchText)
                .disposed(by: disposeBag)
            searchBar.rx.cancelButtonClicked.map{""}.bind(to: viewModel.searchText).disposed(by: disposeBag)
        }
    }
    
    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.placeholder = StaticConstant.searcBarPlaceholder
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}
