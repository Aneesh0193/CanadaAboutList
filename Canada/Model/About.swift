//
//  About.swift
//  Canada
//
//  Created by user on 16/02/24.
//

import Foundation



// MARK: - Row
struct About: Hashable, Codable {
    var title: String?
    var rows: [Rows]?
}

struct Rows: Hashable, Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}

