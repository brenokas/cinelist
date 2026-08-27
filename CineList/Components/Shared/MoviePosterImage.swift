//
//  MoviePosterImage.swift
//  CineList
//
//  Created by breno.farias on 26/08/26.
//

import SwiftUI
import CachedAsyncImage

struct MoviePosterImage: View {
    let url: String?
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Group {
            if let posterPath = url {
                CachedAsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"),
                    urlCache: .imageCache
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        placeholder
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: width, height: height)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius:8))
            } else {
                placeholder
            }
        }
        .frame(width: width, height: height)
        .clipped()
    }
    
    private var placeholder: some View {
        Image(systemName: "film")
            .frame(width: width, height: height)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius:5))
            .border(Color.gray, width: 0.5)
    }
}

#Preview {
    MoviePosterImage(url: nil, width: 100, height: 150)
}
