//
//  Languages.swift
//  CineList
//
//  Created by breno.farias on 20/08/26.
//

enum Languages: String, CaseIterable {
    case en = "en-US"
    case pt = "pt-BR"
    
    var displayName: String {
        switch self {
        case .en:
            return "English"
        case .pt:
            return "Português"
        }
    }
}
