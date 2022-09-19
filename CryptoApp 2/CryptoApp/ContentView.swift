//
//  ContentView.swift
//  CryptoApp
//
//  Created by Antonio Mennillo on 15/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var crypto = [CryptoData]()
    @State var searchcoins = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background").ignoresSafeArea()
                
                VStack{
        //            Title
                    HStack(spacing:5){
                        Text("Crypto").foregroundColor(.white).font(.largeTitle)
                        Text("Box").gradientForeground(colors: [Color(#colorLiteral(red: 0.4274509847, green: 0.8078431487, blue: 0.8078431487, alpha: 1)), .blue])
                            .font(.largeTitle)
                        
                    }.padding(.top,30)
                    
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 20).frame(width: UIScreen.main.bounds.width-40, height: 90, alignment: .center).gradientForeground(colors: [Color(#colorLiteral(red: 0.4274509847, green: 0.8078431487, blue: 0.8078431487, alpha: 1)),.blue])

                        HStack(spacing: UIScreen.main.bounds.width/3){
                            
                        VStack(alignment:.leading, spacing:7){
                            Text("Current Balance").foregroundColor(Color(#colorLiteral(red: 0.04440937191, green: 0.0914305225, blue: 0.1120357886, alpha: 1)))
                            Text("€ 44.321.24").font(.title2).bold().foregroundColor(Color(#colorLiteral(red: 0.04440937191, green: 0.0914305225, blue: 0.1120357886, alpha: 1)))
                        }
                            
                            Image("digital-wallet").foregroundColor(Color(#colorLiteral(red: 0.04440937191, green: 0.0914305225, blue: 0.1120357886, alpha: 1)))
                            
                        }.padding(.leading)
                        
                    }.padding(.top,10)
                        .padding(.bottom,20)
                    
                    
                    VStack(alignment:.leading){
                        VStack(alignment:.leading){
                        Text("Top 10 Ranking").foregroundColor(.white).font(.title2)
                        ZStack {
                                     Rectangle()
                                         .foregroundColor(Color(#colorLiteral(red: 0.09897043556, green: 0.150447607, blue: 0.1752470732, alpha: 1)))
                            
                                     HStack {
                                         Image(systemName: "magnifyingglass").foregroundColor(Color(#colorLiteral(red: 0.4274509847, green: 0.8078431487, blue: 0.8078431487, alpha: 1)))
                                         
                                    ZStack(alignment:.leading){
            //Change placeholder font color
                                         if searchcoins .isEmpty{
                                             Text("Search by name").foregroundColor(.gray)
                                         }
                                         TextField("", text: $searchcoins)
                                   
                                      }.foregroundColor(Color(#colorLiteral(red: 0.4274509847, green: 0.8078431487, blue: 0.8078431487, alpha: 1)))
                                      }.padding(.leading, 13)
                                    
                                     
                                 }
                                     .frame(height: 50)
                                     .frame(width: UIScreen.main.bounds.width-40)
                                     .cornerRadius(15)
                        }.padding(.leading,20)
                        
                        ScrollView(showsIndicators:false){
                        VStack{
                            ForEach(crypto.filter({searchcoins.isEmpty ? true : $0.name.contains(searchcoins)})){ cryptos in
                                
                                    
                                CryptoListView(crypto_name: "\(cryptos.name)", crypto_current_price: cryptos.current_price, crypto_image: cryptos.image, crypto_market_cap_rank: cryptos.market_cap_rank, sparklinedata: cryptos.sparkline_in_7d.price, crypto_market_cap: cryptos.market_cap, percentage_7day: cryptos.price_change_percentage_7d_in_currency, isactive: false)
                        }
                        
                        }.onAppear() {
                                Api().loadData { (cryptos) in
                                    self.crypto = cryptos
                                }
                            }
                        
                        
                        }.padding(.leading).padding(.trailing)
                    
                    
                }.navigationBarHidden(true)
                
               }
            }
        }
       
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        )
            .mask(self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
