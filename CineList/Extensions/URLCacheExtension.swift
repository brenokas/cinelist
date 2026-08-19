//
//  URLCacheExtension.swift
//  CineList
//
//  Created by breno.farias on 19/08/26.
//
import Foundation

extension URLCache {
    static let imageCache: URLCache = {
        URLCache(
            memoryCapacity: 50 * 1024 * 1024,
            diskCapacity: 200 * 1024 * 1024,
            diskPath: "image-cache"
        )
    }()
}
