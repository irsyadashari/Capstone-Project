//
//  FavoriteRow.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 06/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteRow: View {
    
    var place: PlaceModel
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                imageCategory
                content
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Divider()
                .padding(.leading)
        }
    }
    
}

extension FavoriteRow {
    
    var imageCategory: some View {
        WebImage(url: URL(string: place.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 120)
            .cornerRadius(20)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(place.name)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .lineLimit(3)
            
            Text(place.address)
                .font(.system(size: 16))
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
    
}
