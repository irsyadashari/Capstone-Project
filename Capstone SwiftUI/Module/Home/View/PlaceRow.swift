//
//  PlaceRow.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.
//

import SwiftUI
import SDWebImageSwiftUI


struct PlaceRow: View {
    
    @ObservedObject var presenter: HomePresenter
    var place: PlaceModel
    
    var body: some View {
        VStack{
            imagePlace
            Spacer()
            content
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 250)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(30)
    }
}

extension PlaceRow{
    
    var imagePlace: some View{
        WebImage(url: URL(string: place.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 200)
            .cornerRadius(30)
            .padding(.top)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack{
                Spacer()
                Button(action: {toogleFavorite()}){
                    Image(systemName: place.isFavorite ? "star.fill" : "star")
                }
            }
            
            Text(place.name)
                .font(.title)
                .bold()
            
            Text(place.desc)
                .font(.system(size: 14))
                .lineLimit(2)
        }.padding(
            EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        )
    }
    
    struct FavoriteButton: View {
       
        @Binding var presenter: HomePresenter
        @Binding var place: PlaceModel
        
        var body: some View{
            
            HStack{
                Spacer()
                Button(action: {presenter.toggleFavorite(place: place)}){
                    Image(systemName: place.isFavorite ? "star.fill" : "star")
                }
            }
        }
    }
    
    func toogleFavorite(){
        
        presenter.toggleFavorite(place: place)
        print("togle")
    }
    
}
