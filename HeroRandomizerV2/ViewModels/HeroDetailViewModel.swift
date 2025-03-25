//
//  HeroDetailViewModel.swift
//  HeroRandomizerV2
//
//  Created by Alikhan Kassiman on 2025.03.25.
//

import SwiftUI

@MainActor
class HeroDetailViewModel: ObservableObject {
    @Published var hero: HeroDetailModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let heroId: Int
    private let service: HeroService
    
    // Mark initializer as nonisolated so it can be called from non-MainActor contexts
    nonisolated init(heroId: Int, service: HeroService) {
        self.heroId = heroId
        self.service = service
    }
    
    func loadHeroDetails() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let heroEntity = try await service.getHeroDetails(id: heroId)
            
            self.hero = HeroDetailModel(
                id: heroEntity.id,
                name: heroEntity.name,
                fullName: heroEntity.biography.fullName.isEmpty ? heroEntity.name : heroEntity.biography.fullName,
                imageUrl: heroEntity.imageUrl,
                race: heroEntity.appearance.race ?? "Unknown",
                publisher: heroEntity.biography.publisher ?? "Unknown",
                alignment: heroEntity.biography.alignment,
                base: heroEntity.work.base,
                
                intelligence: heroEntity.powerstats.intelligence,
                strength: heroEntity.powerstats.strength,
                speed: heroEntity.powerstats.speed,
                durability: heroEntity.powerstats.durability,
                power: heroEntity.powerstats.power,
                combat: heroEntity.powerstats.combat
            )
            
            self.isLoading = false
            
        } catch {
            self.errorMessage = "Failed to load hero details"
            self.isLoading = false
        }
    }
}
