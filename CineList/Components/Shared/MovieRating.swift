//
//  MovieRating.swift
//  CineList
//
//  Created by breno.farias on 26/08/26.
//

import SwiftUI

struct MovieRating: View {
    let rating: Double?
    
    var body: some View {
        HStack(spacing:3){
            Image(systemName:"star.fill").foregroundStyle(.yellow)
            
            if let voteAverage = rating {
                Text((voteAverage/2)
                    .formatted(.number.precision(.fractionLength(1))))
            } else {
                Text("0,0")
            }
            
        }
    }
}

#Preview {
    MovieRating(rating: 3.6)
}
