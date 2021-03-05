//
//  GifCell.swift
//  Gifs App
//
//  Created by Slava Kuzmitsky on 03.03.2021.
//  Copyright © 2021 Slava Kuzmitsky. All rights reserved.
//

import UIKit

class GifCell: UITableViewCell {

    @IBOutlet private weak var gifImageView: UIImageView!
    
    func configureCell(image: UIImage?){
        gifImageView.image = image
        gifImageView.sizeToFit()
    }
}
