import SwiftUI

struct CatBreedRowView: View {
    @ObservedObject var viewModel: CatBreedRowViewModel

    var body: some View {
        HStack(alignment: .top) {
            if viewModel.breed.referenceImageID != nil {
                if let image = viewModel.image {
                    if image == UIImage(named: "cat") {
                        Image("cat")
                            .myImageModifier()
                            .foregroundColor(.gray)

                    } else {
                        Image(uiImage: image)
                            .myImageModifier()
                    }
                } else {
                    ProgressView()
                        .padding()
                        .frame(width: 100, height: 100)
                        .onAppear {
                            viewModel.loadImage()
                        }
                }
            } else {
                Image("cat")
                    .myImageModifier()
                    .foregroundColor(.gray)
            }

            VStack(alignment: .leading) {
                Text(viewModel.breed.name)
                    .font(.headline)
                Text(viewModel.breed.temperament)
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
    }
}

extension Image {
    func myImageModifier() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(10)
   }
}


struct CatBreedRowView_Previews: PreviewProvider {
    static let catBreed = CatBreed(
        id: "abc",
        name: "Catty",
        temperament: "Affectionate, Dependent, Gentle, Intelligent, Playful",
        description: "Meow, meow, meeooow, memeoooow, meowee!",
        referenceImageID: "meowee"
    )

    static let viewModel = CatBreedRowViewModel(breed: catBreed)

    static var previews: some View {
        CatBreedRowView(viewModel: viewModel)
    }
}
