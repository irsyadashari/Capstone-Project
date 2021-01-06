//
//  PlaceView.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 06/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PlaceView: View {
    
    @State private var showingAlert = false
    @ObservedObject var presenter: PlacePresenter
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imagePlace
                        content
                    }.padding()
                }
            }
        }.onAppear {
            self.presenter.getPlace()
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Oops!"),
                message: Text("Something wrong!"),
                dismissButton: .default(Text("OK"))
            )
        }.navigationBarTitle(
            Text(presenter.place.name),
            displayMode: .automatic
        )
    }
    
}

extension PlaceView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var imagePlace: some View {
        WebImage(url: URL(string: self.presenter.place.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width - 32, height: 250.0, alignment: .center)
            .cornerRadius(30)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(presenter.place.name)
                .font(.system(size: 24))
            
            Text(presenter.place.address)
                .font(.system(size: 20))
            
            Text(presenter.place.desc)
                .font(.system(size: 16))
            
            Divider()
                .padding(.vertical)
            
        }.padding(.top)
    }
    
}

extension PlaceView {
    
    func openUrl(_ linkUrl: String) {
        if let link = URL(string: linkUrl) {
            UIApplication.shared.open(link)
        } else {
            showingAlert = true
        }
    }
    
}

