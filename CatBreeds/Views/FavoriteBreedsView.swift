import SwiftUI

struct FavoriteBreedsView: View {
    @ObservedObject private var viewModel = FavoriteBreedsViewModel()
    @State private var isShowingDelete = false

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.catBreeds.isEmpty {
                    Image("cat")
                        .myImageModifier()
                    Text("Start favoriting cat breeds from cat breed details.")
                        .font(.subheadline)
                } else {
                    List {
                        ForEach(viewModel.catBreeds, id: \.id) { breed in
                            VStack {
                                HStack {
                                    Text(breed.name)
                                        .font(.headline)
                                        .padding(.vertical, 12)
                                    Spacer()
                                    if isShowingDelete {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                            .background(Color.clear)
                                            .onTapGesture {
                                                viewModel.removeFavorite(forBreed: breed)
                                            }
                                    }
                                }

                                Text(breed.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                HStack(alignment: .center) {
                                    Spacer()
                                    if let imageID = breed.referenceImageID {
                                        if let image = viewModel.images[imageID] {
                                            if image == UIImage(named: "cat") {
                                                Image("cat")
                                                    .myImageModifier()
                                            } else {
                                                Image(uiImage: image)
                                                    .myImageModifier()
                                            }
                                        } else {
                                            ProgressView()
                                                .onAppear {
                                                    viewModel.loadImage(for: imageID)
                                                }
                                        }
                                    } else {
                                        Image("cat")
                                            .myImageModifier()
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorite breeds")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingDelete.toggle()
                    } label: {
                        HStack {
                            Image(systemName: isShowingDelete ? "xmark" : "trash")
                        }
                    }
                }
            }

            .onAppear {
                viewModel.getFavorites()
            }
        }
    }
}

private extension Image {
    func myImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 150)
            .cornerRadius(10)
            .foregroundColor(.gray)
   }
}

struct FavoriteBreedsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteBreedsView()
    }
}
