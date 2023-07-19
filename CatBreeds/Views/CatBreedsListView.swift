import SwiftUI

struct CatBreedsListView: View {
    @ObservedObject private var viewModel = CatBreedsListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.catBreeds, id: \.id) { breed in
                    NavigationLink {
                        CatBreedDetailsView(viewModel: CatBreedDetailsViewModel(breed: breed))
                    } label: {
                        CatBreedRowView(viewModel: CatBreedRowViewModel(breed: breed))
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
