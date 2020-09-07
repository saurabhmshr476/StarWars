//
//  DetailViewController.swift
//  StarWars
//
//  Created by SaurabhMishra on 06/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    // MARK: - Properties
    
    var personDetails:Person?
    private lazy var viewModel = DetailViewModel(person: personDetails!)
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
           didSet {
               collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
           }
       }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var filmCollectionView: UICollectionView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mass: UILabel!
    @IBOutlet weak var hairColor: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var birthYear: UILabel!
    @IBOutlet weak var skinColor: UILabel!
    @IBOutlet weak var eyeColor: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    // MARK: - ViewController LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        bindView()
    }
    
     // MARK: - Setup
    
    func setUp(){
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false;
        scrollView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        collectionLayout.scrollDirection = .horizontal
        filmCollectionView.delegate = self
        filmCollectionView.dataSource = self
        activityIndicator.hidesWhenStopped = true

    }
    
    // MARK: - Bind Views
    
    func bindView(){
        
        viewModel.name.bind {[weak self] (name) in
            self?.name.text = name
        }
        
        viewModel.birthYear.bind {[weak self] (birthYear) in
            self?.birthYear.text = birthYear
        }
        viewModel.height.bind {[weak self] (height) in
            self?.height.text = height
        }
        viewModel.eyeColor.bind {[weak self] (eyeColor) in
            self?.eyeColor.text = eyeColor
        }
        viewModel.skinColor.bind {[weak self] (skinColor) in
           self?.skinColor.text = skinColor
        }
        viewModel.hairColor.bind {[weak self] (hairColor) in
           self?.hairColor.text = hairColor
        }
        viewModel.gender.bind {[weak self] (gender) in
            self?.gender.text = gender
        }
        viewModel.mass.bind {[weak self] (mass) in
            self?.mass.text = mass
        }
        viewModel.progress.bind {[weak self] (progress) in
                if progress{
                    self?.filmCollectionView.isHidden = true
                    self?.activityIndicator.startAnimating()
                }else{
                    self?.activityIndicator.stopAnimating()
                    self?.filmCollectionView.isHidden = false
                    self?.filmCollectionView.reloadData()
               }
        }
        guard let flimUrls = personDetails?.films else{return}
        viewModel.downloadfilmData(films: flimUrls)
    }
}
// MARK: - Collection View DataSource & Delegate

extension DetailViewController:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.filmData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseID, for: indexPath) as! FilmCollectionViewCell
        cell.configure(cell: cell, film: viewModel.filmData[indexPath.item])
        return cell
    }
       
}


// MARK: - Constants

private enum Constants {
    static let reuseID = "filmCell"
}
