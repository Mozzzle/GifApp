//
//  StaticConstant.swift
//  Gifs App
//
//  Created by Slava Kuzmitsky on 03.03.2021.
//  Copyright © 2021 Slava Kuzmitsky. All rights reserved.
//

import Foundation

struct StaticConstant {
    static let nibName = "GifCell"
    static let cellIdentifier = "Cell"
    static let searcBarPlaceholder = "Search gifs"
    static let urlStringToGetTrends = "https://api.giphy.com/v1/gifs/trending?api_key=1LpWYnpcWuwxDBuzqqpWxrmUTgm9pMO6&limit=5&rating=g"
    static let urlStringToSearchBegin = "https://api.giphy.com/v1/gifs/search?api_key=1LpWYnpcWuwxDBuzqqpWxrmUTgm9pMO6&q="
    static let urlStringToSearchEnd = "&limit=5&offset=0&rating=g&lang=en"
}
