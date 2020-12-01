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
            .overlay(
                VStack {
                    spacer
                    HStack {
                        spacer
                        Image("like")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                        
                        Text(" \(self.presenter.place.like)")
                            .foregroundColor(Color.pink)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .padding(.bottom, 24)
                }
            )
    }
    
    var description: some View {
        Text(self.presenter.place.desc)
            .font(.system(size: 15))
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.presenter.place.name)
                .font(.system(size: 28, weight: .bold, design: .rounded))
            Text(self.presenter.place.address)
                .foregroundColor(Color(.gray))
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .padding(.bottom, 24)
            description
        }.padding()
    }
}
