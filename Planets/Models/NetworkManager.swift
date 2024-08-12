//
//  NetworkManager.swift
//  Planets
//
//  Created by Furkan Ceylan on 12.08.2024.
//

import Foundation

struct NetworkManager {
    
    func getData(with planetName: String, completion: @escaping ([PlanetDataModel]) -> Void) {
        guard let name = planetName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.api-ninjas.com/v1/planets?name="+name) else {return}
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            // Parse Data
            guard let planetModel = self.parseData(data: data) else {return}
            DispatchQueue.main.async {
                
                completion(planetModel)
            }
        }
        task.resume()
    }
    
    private func parseData(data: Data) -> [PlanetDataModel]?{
        let jsonDecoder = JSONDecoder()
        do{
            
            let planetModel = try jsonDecoder.decode([PlanetDataModel].self, from: data)
            return planetModel
        }catch{
            print(error.localizedDescription)
        }
        return nil
    }
}
