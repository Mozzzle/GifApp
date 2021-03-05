//
//  APIProvider.swift
//  Gifs App
//
//  Created by Slava Kuzmitsky on 02.03.2021.
//  Copyright © 2021 Slava Kuzmitsky. All rights reserved.
//

import Foundation
import RxSwift

class APIProvider {
    
    func getGifs(_ search: String) -> Observable<[Gif]> {
        var urlString = ""
        if search.isEmpty {
            urlString = StaticConstant.urlStringToGetTrends
        }
        else {
            urlString = StaticConstant.urlStringToSearchBegin + search.replacingOccurrences(of: " ", with: "_") + StaticConstant.urlStringToSearchEnd
        }
        guard let url = URL(string: urlString) else { return Observable.just([]) }
        return URLSession.shared
            .rx.json(request: URLRequest(url: url))
            .map {
                var gifs = [Gif]()
                var urlString = ""
                if let items = $0 as? [String: AnyObject] {
                    let data = items["data"] as! [[String:AnyObject]]
                    data.forEach{ singlData in
                        guard let images = singlData["images"] as? [String: AnyObject],
                            let original = images["original"] as? [String: AnyObject],
                            let url = original["url"] as? String else { return }
                        urlString = String(url)
                        gifs.append(Gif(url: urlString) )
                    }
                }
                return gifs
        }
    }
}
