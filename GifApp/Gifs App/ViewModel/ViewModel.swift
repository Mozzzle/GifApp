//
//  ViewModel.swift
//  Gifs App
//
//  Created by Slava Kuzmitsky on 03.03.2021.
//  Copyright © 2021 Slava Kuzmitsky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ViewModel {
    private let apiProvider: APIProvider
    let searchText = Variable("")
    
    var data: Driver<[Gif]>
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
        
        data = self.searchText.asObservable()
            .throttle(1, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest {
                apiProvider.getGifs($0)
            }.asDriver(onErrorJustReturn: [])
    }
}
