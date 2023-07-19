import SwiftUI

struct OverviewView: View {
    var body: some View {
        TabView {
            CatBreedsListView()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            FavoriteBreedsView()
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
