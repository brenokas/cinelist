//
//  FavoriteMovieButton.swift
//  CineList
//
//  Created by breno.farias on 26/08/26.
//

import SwiftUI

struct FavoriteMovieButton: View {
    let isFavorite: Bool
    let action: () -> Void
    
    var body: some View {
        Button (action: action){
            Label(
                isFavorite ? "Added to favorites" : "Add to favorites",
                systemImage: isFavorite ? "heart.fill" : "heart"
            )
        }
        .foregroundStyle(.background)
        .padding(10)
        .background(
            isFavorite
            ? .red
            : .gray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .animation(.smooth, value: isFavorite)
    }
}

#Preview {
    FavoriteMovieButton(isFavorite: false) {}
        .padding()
}
