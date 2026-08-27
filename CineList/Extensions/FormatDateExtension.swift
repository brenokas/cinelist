//
//  FormatDateExtension.swift
//  CineList
//
//  Created by breno.farias on 26/08/26.
//

import Foundation

extension String {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let date = formatter.date(from: self) else {
            return self
        }
        
        return outputFormatter.string(from: date)
    }
}
