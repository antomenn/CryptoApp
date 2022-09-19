//
//  CryptoData.swift
//  CryptoApp
//
//  Created by Antonio Mennillo on 15/09/22.
//

import Foundation

struct CryptoData: Codable,Identifiable {
    let id = UUID()
    var name: String
    var current_price: Double
    var image : String
    var market_cap_rank: Int
    var market_cap: Int
    var price_change_percentage_7d_in_currency: Double
    var sparkline_in_7d: SparklineData
}

struct SparklineData: Codable{
    var price:[Double]
}

class Api : ObservableObject{
    @Published var crypto = [CryptoData]()
    
    func loadData(completion:@escaping ([CryptoData]) -> ()) {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=10&page=1&sparkline=true&price_change_percentage=7d") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let crypto = try! JSONDecoder().decode([CryptoData].self, from: data!)
            print(crypto)
            DispatchQueue.main.async {
                completion(crypto)
            }
        }.resume()
        
    }
}
