//
//  FlimCollectionViewCell.swift
//  StarWars
//
//  Created by SaurabhMishra on 06/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var filmName: UILabel!
    
}
extension FilmCollectionViewCell {

    func decorate() {
        let radius: CGFloat = 5
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = true

    }
    
    func configure(cell:FilmCollectionViewCell,film:Film?){
            self.filmName.text = film?.title
            let components = film?.openingCrawl.components(separatedBy: .whitespacesAndNewlines)
            let words = components?.filter { !$0.isEmpty }
            self.count.text = "Count: \(words?.count ?? 0)"
            self.decorate()
    }
}
