//
//  DetailsView.swift
//  CryptoApp
//
//  Created by Antonio Mennillo on 17/09/22.
//

import SwiftUI

struct DetailsView: View {
    
    @State var name_details: String
    @State var sparklinedata_details : [Double]
    @State var image_details: String
    @State var current_price_details: Double
    @State var market_cap_rank_details: Int
    @State var market_cap_details: Int
    @State var percentage_7days_details:Double
    
    @State var max_price: Double
    @State var min_price: Double
    

    var body: some View {
       
                    
            ZStack{
                Color("Background").ignoresSafeArea()
                VStack {
                    Text("Details").font(.title).foregroundColor(.yellow).padding(.bottom,30)
                
                    VStack(alignment:.center){
                    HStack(spacing:30){
                    
                AsyncImage(url: URL(string: "\(image_details)")) { image in
                       image
                           .resizable()
                           .scaledToFill()
                   } placeholder: {
                       ProgressView()
                   }
                   .frame(width: 70, height: 70)
                    LazyVStack(alignment:.leading){
                    LazyHStack{
                        Text("Name:").foregroundColor(.white)
                        Text("\(name_details)").foregroundColor(Color(#colorLiteral(red: 0.4274509847, green: 0.8078431487, blue: 0.8078431487, alpha: 1)))
                    }
                    LazyHStack{
                        Text("Current Price:").foregroundColor(.white)
                        Text("€ \(current_price_details)").foregroundColor(Color(#colorLiteral(red: 0.4274509847, green: 0.8078431487, blue: 0.8078431487, alpha: 1)))
                    }
                        
                    LazyHStack{
                        Text("Market Cap:").foregroundColor(.white)
                        Text("€ \(market_cap_details)").foregroundColor(Color(#colorLiteral(red: 0.4274509847, green: 0.8078431487, blue: 0.8078431487, alpha: 1)))
                    }
                }
                }.padding(.leading,20)
                .padding(.bottom,30)
                        
                    LazyVStack(alignment:.leading,spacing:30){
                        HStack(spacing:UIScreen.main.bounds.width/3){
                    Text("Last 7 days").font(.title3).foregroundColor(.yellow)
                            
                            if percentage_7days_details<0{
                                Text("\(percentage_7days_details)%").foregroundColor(.red).font(.title3)
                            }
                            else{
                                Text("+\(percentage_7days_details)%").foregroundColor(.green).font(.title3)
                            }
                        }
                    LineShape(yValues: sparklinedata_details)
                            .stroke(Color(#colorLiteral(red: 0.4274509847, green: 0.8078431487, blue: 0.8078431487, alpha: 1)), lineWidth: 2.0)
                            .frame(width: 350, height: 400).padding(.bottom,50)
                    HStack{
                            
                    Text("Max Price:").foregroundColor(.white)
                    Text("€ \(max_price)").onAppear(perform: FindMax).foregroundColor(Color(#colorLiteral(red: 0.4274509847, green: 0.8078431487, blue: 0.8078431487, alpha: 1)))
                    
                    }.padding(.top,-350)
                     .padding(.bottom,10)
                        
                    HStack{
                                
                        Text("Min Price:").foregroundColor(.white)
                        Text("€ \(min_price)").onAppear(perform: FindMin).foregroundColor(Color(#colorLiteral(red: 0.4274509847, green: 0.8078431487, blue: 0.8078431487, alpha: 1)))
                        
                        }.padding(.top,-350)
                    
                        
                    }.padding(.leading,20)
        
                }
        }
    }
}
    func FindMax(){
        
        max_price = sparklinedata_details.max() ?? 1
    }
    
    func FindMin(){
        
        min_price = sparklinedata_details.min() ?? 1
    }

}

struct LineShape: Shape {
    var yValues: [Double]
    
    func path(in rect: CGRect) -> Path {
        let xIncrement = (rect.width / (CGFloat(yValues.count) - 1))
        let factor = rect.height / CGFloat(yValues.max() ?? 1.0)
        var path = Path()
        path.move(to: CGPoint(x: 0.0,
                              y: (rect.height - (yValues[0] * factor))))
        for i in 1..<yValues.count {
            let pt = CGPoint(x: (Double(i) * Double(xIncrement)),
                             y: (rect.height - (yValues[i] * factor)))
            path.addLine(to: pt)
        }
        return path
    }
}


struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(name_details: "Bitcoin", sparklinedata_details: [120.0,123.11,123.4], image_details: "image.example", current_price_details:  19.220, market_cap_rank_details: 1, market_cap_details: 10000, percentage_7days_details: 7.1, max_price: 10.0, min_price: 1.0)
    }
}
