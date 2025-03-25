//
//  HeroService.swift
//  HeroRandomizerV2
//
//  Created by Alikhan Kassiman on 2025.03.25.
//

import Foundation

enum HeroError: Error {
    case invalidUrl
    case networkError
    case decodingError
}

protocol HeroService {
    func getHeroes() async throws -> [HeroEntity]
    func getHeroDetails(id: Int) async throws -> HeroDetailEntity
}

class HeroServiceImpl: HeroService {
    private let baseUrl = "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/"
    
    func getHeroes() async throws -> [HeroEntity] {
        guard let url = URL(string: baseUrl + "all.json") else {
            throw HeroError.invalidUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([HeroEntity].self, from: data)
        } catch {
            print("Error fetching heroes: \(error)")
            if error is DecodingError {
                throw HeroError.decodingError
            }
            throw HeroError.networkError
        }
    }
    
    func getHeroDetails(id: Int) async throws -> HeroDetailEntity {
        guard let url = URL(string: baseUrl + "id/\(id).json") else {
            throw HeroError.invalidUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(HeroDetailEntity.self, from: data)
        } catch {
            print("Error fetching hero details: \(error)")
            if error is DecodingError {
                throw HeroError.decodingError
            }
            throw HeroError.networkError
        }
    }
}
