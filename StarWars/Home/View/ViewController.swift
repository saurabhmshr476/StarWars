//
//  ViewController.swift
//  StarWars
//
//  Created by SaurabhMishra on 06/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    // MARK: - Properties
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private let viewModel = HomeViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ViewController LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bindView()
    }

    // MARK: - Setup
    
    func setUp(){
        title = "Star Wars"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
    }

    // MARK: - View Bindings
    
    func bindView(){
        
        viewModel.progress.bind {[weak self] (progress) in
            if progress{
                self?.tableView.isHidden = true
                self?.activityIndicator.startAnimating()
            }else{
               self?.activityIndicator.stopAnimating()
               self?.tableView.isHidden = false
               self?.tableView.reloadData()
            }
        }
        viewModel.fetchPersons()
    }
}


// MARK: - TableView View Delegate

extension ViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        nextViewController.personDetails = viewModel.persons[indexPath.row]
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
}
 
// MARK: - TableView View DataSource

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.persons.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = viewModel.persons[indexPath.row]
        cell.textLabel?.text  = person.name
        return cell
       }
}
