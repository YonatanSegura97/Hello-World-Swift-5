//
//  ViewController.swift
//  Example1MVVM
//
//  Created by Macbook on 6/27/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    var viewModel = ViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }

    private func configureView(){
        self.activity.isHidden = false
        activity.startAnimating()
        viewModel.getDataResponse()
        
        
    }
    
    private func bind(){
        viewModel.dataResponse = { [weak self] () in
            DispatchQueue.main.async{
            
                self?.table.reloadData()
                self?.activity.stopAnimating()
                self?.activity.isHidden = true
            }
            
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let object = viewModel.list[indexPath.row]
        cell.textLabel?.text = object.title
        cell.detailTextLabel?.text = object.body
        
        
        return cell
    }
    
    
}
