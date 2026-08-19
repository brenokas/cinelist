//
//  FavoritesView.swift
//  CineList
//
//  Created by breno.farias on 18/08/26.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
        
    var body: some View {
        List(favoritesViewModel.favorites) { movie in
            Text(movie.title)
        }
    }
}

#Preview {
    let viewModel = FavoritesViewModel()

        viewModel.favorites = [
            Movie(
                id: 1,
                backdrop_path: nil,
                title: "Interestelar",
                overview: "Uma equipe viaja pelo espaço em busca de um novo lar para a humanidade.",
                poster_path: nil,
                release_date: "2014-11-06",
                vote_average: 8.6,
                vote_count: 1000
            ),
            Movie(
                id: 2,
                backdrop_path: nil,
                title: "O Poderoso Chefão",
                overview: "A história de uma das famílias mais importantes da máfia.",
                poster_path: nil,
                release_date: "1972-03-24",
                vote_average: 8.7,
                vote_count: 2000
            ),
            Movie(
                id: 3,
                backdrop_path: nil,
                title: "Parasita",
                overview: "Uma família tenta mudar sua condição social de forma inesperada.",
                poster_path: nil,
                release_date: "2019-05-30",
                vote_average: 8.5,
                vote_count: 1500
            )
        ]
    
    return FavoritesView()
        .environmentObject(viewModel)
    
}
