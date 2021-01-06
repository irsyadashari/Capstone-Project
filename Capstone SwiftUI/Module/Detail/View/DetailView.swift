//
//  DetailView.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  
  @ObservedObject var presenter: DetailPresenter
  
  var body: some View {
    ZStack {
      if presenter.loadingState {
        loadingIndicator
      } else {
        ScrollView(.vertical) {
          VStack {
            imagePlace
            content
          }
        }
      }
    }
  }
}

extension DetailView {
  var spacer: some View {
    Spacer()
  }
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading")
      ProgressView()
    }
  }
  
  var imagePlace: some View {
    WebImage(url: URL(string: self.presenter.place.image))
      .resizable()
      .indicator(.activity)
      .scaledToFill()
      .background(Color(.systemPink))
      .transition(.fade(duration: 0.5))
      .frame(width: 300, height: 300, alignment: .center)
      .ignoresSafeArea()
  }
  
  var description: some View {
    Text(self.presenter.place.desc)
      .font(.system(size: 15))
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 0) {
      
      HStack {
        Text(self.presenter.place.name)
          .font(.system(size: 28, weight: .bold, design: .rounded))
      }
      
      Text(self.presenter.place.address)
        .foregroundColor(Color(.gray))
        .font(.system(size: 14, weight: .bold, design: .rounded))
        .padding(.bottom, 24)
      description
    }.padding()
    
    .accentColor(.pink)
  }
}
