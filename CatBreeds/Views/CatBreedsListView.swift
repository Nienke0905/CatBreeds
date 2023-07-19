import SwiftUI

struct CatBreedsListView: View {
    @ObservedObject private var viewModel = CatBreedsListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.catBreeds, id: \.id) { breed in
                    VStack {
                        Text(breed.name)
                        Text(breed.description)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .padding()
            .navigationTitle("Cats")
            .onAppear {
                viewModel.fetchCatBreeds()
            }
        }
    }
}

struct CatBreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedsListView()
    }
}
