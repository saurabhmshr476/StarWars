//
//  DetailViewModel.swift
//  StarWars
//
//  Created by SaurabhMishra on 07/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import Foundation

class DetailViewModel{
    // MARK: - Properties
    private let networkManager = Service.shared
    
    var name = Box("")
    var mass = Box("")
    var hairColor = Box("")
    var height = Box("")
    var birthYear = Box("")
    var skinColor = Box("")
    var eyeColor = Box("")
    var gender = Box("")
    var filmData = [Film]()
    var progress = Box(false)
    
    init(person:Person) {
        self.name.value = person.name
        self.mass.value = person.mass
        self.height.value = person.height
        self.eyeColor.value = person.eyeColor
        self.skinColor.value = person.skinColor
        self.hairColor.value = person.hairColor
        self.gender.value = person.gender
        self.birthYear.value = person.birthYear
    }
    // MARK: - Download Flim Data
    
    func downloadfilmData(films:[String]?){

        let dispatchGroup = DispatchGroup()
        guard let flimUrls = films else{return}
        progress.value = true
        for i in 0..<flimUrls.count {
           dispatchGroup.enter()
            
            networkManager.getFlim(urlStr: flimUrls[i]) {[weak self] (film, err) in
                if let err = err {
                    print("Failed to fetch courses:", err)
                    return
                }
                self?.filmData.append(film!)
                dispatchGroup.leave()
               
            }
                
        }
        
        dispatchGroup.notify(queue: .main) {
            self.progress.value = false
        }
    }
    
}

