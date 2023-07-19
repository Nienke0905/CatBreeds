import SwiftUI

struct CatBreedDetailsView: View {
    @ObservedObject var viewModel: CatBreedDetailsViewModel

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .myImageModifier()
                        .frame(height: geo.size.height/2)

                } else {
                    Image("cat")
                        .myImageModifier()
                        .frame(height: geo.size.height/2)
                }

                VStack(alignment: .center) {
                    Text(viewModel.breed.name)
                        .font(.title)
                        .padding(.bottom)
                    Text(viewModel.breed.description)
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundColor(.gray)

                }
                .padding(20)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.toggleIsFavorited()
                    } label: {
                        Image(systemName: viewModel.isFavorited ? "heart.fill" : "heart")
                            .imageScale(.large)
                    }

                }
            }
            .onAppear {
                viewModel.loadIsFavorited()
            }
        }
    }
}

private extension Image {
    func myImageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .foregroundColor(.gray)
   }
}

struct CatBreedDetailsView_Previews: PreviewProvider {
    static let catBreed = CatBreed(
        id: "abc",
        name: "Catty",
        temperament: "Affectionate, Dependent, Gentle, Intelligent, Playful",
        description: "Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee!Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee!Meow, meow, meeooow, memeoooow, meowee!",
        referenceImageID: "meowee"
    )

    static let viewModel = CatBreedDetailsViewModel(breed: catBreed)

    static var previews: some View {
        CatBreedDetailsView(viewModel: viewModel)
    }
}
