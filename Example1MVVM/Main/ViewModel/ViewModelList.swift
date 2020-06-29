//
//  ViewModelList.swift
//  Example1MVVM
//
//  Created by Macbook on 6/27/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation

class ViewModelList {
    
    // Las llamadas a la API no van en el viewModel sino que se crearia una capa de conexion
    
    // GET API RESPONSE
    var dataResponse = { ()->() in }
    var list:[List] = [] {
        didSet{
            dataResponse()
        }
    }

    
    func getDataResponse() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{ return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else { return }
            
            //Serializar los datos
            do{
                let decoder = JSONDecoder()
                self.list =  try decoder.decode([List].self, from: json)
            }catch let error{
                print("An error happened \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    
}

