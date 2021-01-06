//
//  PlaceRow.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Place

struct PlaceRow: View {
    
    var place: PlaceDomainModel
    
    var body: some View {
        VStack {
            imagePlace
            content
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 450)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(24)
        .transition(.move(edge: .bottom))
        .animation(.spring())
    }
}

extension PlaceRow {
    
    var imagePlace: some View {
        WebImage(url: URL(string: place.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300, alignment: .topLeading)
            
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(place.name)
                .font(.title)
                .bold()
          
            Text(place.desc)
                .font(.system(size: 14))
                .lineLimit(6)
        }.padding(
            EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 0,
                trailing: 16
            )
        )
    }
    
}

struct PlaceRow_Previews: PreviewProvider {
    static var previews: some View {
        let place = PlaceDomainModel(id: 1, name: "TN Kelimutu",
                                     desc: "Taman Nasional Kelimutu terletak di Flores, Indonesia. Taman nasional ini terdiri dari bukit-bukit dan gunung-gunung dengan Gunung Kelibara (1.731 m) sebagai puncak tertinggi. Gunung Kelimutu, terdapat danau Danau tiga warna yang juga merupakan tempat dari Taman Nasional Kelimutu.\n\nDi dalam Taman Nasional Kelimutu, terdapat arboretum, hutan kecil seluas 4,5 hektare yang mewakili koleksi keanekaragaman flora di daerah tersebut. Di sana terdapat 78 jenis pohon yang dikelompokkan ke dalam 36 suku. Beberapa koleksi flora yang merupakan endemik Kelimutu adalah uta onga (Begonia kelimutuensis), turuwara (Rhododendron renschianum), dan arngoni (Vaccinium varingiaefolium).",
                                     address: "Detusoko, Kabupaten Ende, NTT",
                                     like: 22, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Kelimutu_2008-08-08.jpg/800px-Kelimutu_2008-08-08.jpg", isFavorite: false)
        PlaceRow(place: place)
    }
}
