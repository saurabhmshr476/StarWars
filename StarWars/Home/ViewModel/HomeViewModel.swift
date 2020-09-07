//
//  HomeViewModel.swift
//  StarWars
//
//  Created by SaurabhMishra on 07/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var persons = [Person]()
    var progress = Box(false)
    private let networkManager = Service.shared
    
    // MARK: - Fetch Person 
    func fetchPersons(){
        progress.value = true
            networkManager.getPeople {[weak self] (peopleData, err) in
                
                if let err = err {
                    print("Failed to fetch courses:", err)
                    self?.progress.value = false

                    return
                }
                self?.persons = peopleData?.results.sorted(by: { $0.name < $1.name }) ?? []
                self?.progress.value = false

               
            }
        }

    }

