//
//  HeroListModel.swift
//  HeroRandomizerV2
//
//  Created by Alikhan Kassiman on 2025.03.25.
//

import Foundation

struct HeroListModel: Identifiable {
    let id: Int
    let name: String
    let race: String
    let imageUrl: URL?
}
