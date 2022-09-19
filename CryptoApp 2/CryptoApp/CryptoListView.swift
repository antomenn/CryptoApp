//
//  CryptoListView.swift
//  CryptoApp
//
//  Created by Antonio Mennillo on 16/09/22.
//

import SwiftUI

struct CryptoListView: View {
    
    @State var crypto_name: String
    @State var crypto_current_price: Double
    @State var crypto_image : String
    @State var crypto_market_cap_rank: Int
    @State var sparklinedata : [Double]
    @State var crypto_market_cap: Int
    @State var percentage_7day: Double
    
    @State var isactive : Bool
    
    var body: some View {
        
        ZStack(alignment:.leading){
            Rectangle()
                .fill(Color("Background"))
               .frame(height:100)
//    Crypto List layout
            HStack(alignment: .center, spacing: 10){
                
                Text("\(crypto_market_cap_rank).")
                    .foregroundColor(.yellow)
                    .font(.title2)
                
                AsyncImage(url: URL(string: "\(crypto_image)")) { image in
                       image
                           .resizable()
                           .scaledToFill()
                   } placeholder: {
                       ProgressView()
                   }
                   .frame(width: 30, height: 50)
                   .padding()
                HStack{
                VStack(alignment:.leading, spacing:5){
                Text(crypto_name)
                    .font(.title3)
                    .foregroundColor(.white)
                    
                    
    
                Text("€ \(crypto_current_price)")
                        .foregroundColor(Color(#colorLiteral(red: 0.4274509847, green: 0.8078431487, blue: 0.8078431487, alpha: 1)))
                    
                    

                }
                Button{
                    self.isactive = true
                }label: {
                    Image(systemName: "info.circle").foregroundColor(.yellow).font(.title) .frame(maxWidth:.infinity,alignment: .trailing)
                    
                }.sheet(isPresented: $isactive){
                    
                    DetailsView(name_details: crypto_name, sparklinedata_details: sparklinedata, image_details: crypto_image, current_price_details: crypto_current_price, market_cap_rank_details: crypto_market_cap_rank, market_cap_details: crypto_market_cap, percentage_7days_details: percentage_7day, max_price: 10.0, min_price: 1.0)
                }
                }
                
            }
        }
}
}

struct CryptoListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListView(crypto_name: "Bitcoin", crypto_current_price: 19.220, crypto_image: "ciao", crypto_market_cap_rank: 1, sparklinedata: [120.0,123.11,123.4], crypto_market_cap: 1000, percentage_7day: 7.1, isactive: false)
    }
}
