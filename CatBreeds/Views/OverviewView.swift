//
//  OverviewView.swift
//  CatBreeds
//
//  Created by Nienke Westdijk on 19.07.23.
//

import SwiftUI

struct OverviewView: View {
    var body: some View {
        TabView {
            CatBreedsListView()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            CatBreedsListView()
                .tabItem{
                    Label("Favorites", systemImage: "heart")
                }
        }    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}
