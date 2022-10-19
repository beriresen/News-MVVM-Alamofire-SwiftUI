//
//  RemoteImageView.swift
//  Projects
//
//  Created by BRR on 7.08.2022.
//

import SwiftUI

final class ImageLoader: ObservableObject {

    @Published var image: Image? = nil

    func load(fromURL url: String) {
        NetworkManager.instance.downloadImage(from: url) { uiImage in
            guard let uiImage = uiImage else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}
struct RemoteImageView: View {
    
    var image: Image?

    var body: some View {
        if let image = image {
            image.resizable().centerCropped()
        }else{
            Image(systemName: "circle.hexagonpath.fill").frame(width: 64, height: 64, alignment: .center)
        }
    }
}

struct RemoteImage: View {

    @StateObject private var imageLoader = ImageLoader()
    var urlString: String

    var body: some View {
        RemoteImageView(image: imageLoader.image)
            .onAppear { imageLoader.load(fromURL: urlString) }
    }
}
