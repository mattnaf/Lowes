//
//  Movie.swift
//  MovieBrowser
//
//  Created by matt nafarrete on 7/20/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct Movie: Hashable, Codable {
    let title: String?
    let releaseDate: String?
    let voteAverage: Double?
    let overview: String?
    let posterPath: String
}

struct MovieResponse: Hashable, Codable {
    let results: [Movie]
}
