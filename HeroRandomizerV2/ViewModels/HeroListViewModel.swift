//
//  HeroListViewModel.swift
//  HeroRandomizerV2
//
//  Created by Alikhan Kassiman on 2025.03.25.
//

import SwiftUI
import Combine

@MainActor
class HeroListViewModel: ObservableObject {
    @Published var heroes: [HeroListModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    
    private var allHeroes: [HeroListModel] = []
    private let service: HeroService
    private let router: HeroRouter
    private var cancellables = Set<AnyCancellable>()
    
    init(service: HeroService, router: HeroRouter) {
        self.service = service
        self.router = router
        
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.filterHeroes(searchText: text)
            }
            .store(in: &cancellables)
    }
    
    func loadHeroes() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let heroEntities = try await service.getHeroes()
            
            self.allHeroes = heroEntities.map { entity in
                HeroListModel(
                    id: entity.id,
                    name: entity.name,
                    race: entity.appearance.race ?? "Unknown",
                    imageUrl: entity.imageUrl
                )
            }
            
            filterHeroes(searchText: searchText)
            isLoading = false
            
        } catch {
            errorMessage = "Failed to load heroes"
            isLoading = false
        }
    }
    
    func filterHeroes(searchText: String) {
        if searchText.isEmpty {
            heroes = allHeroes
        } else {
            heroes = allHeroes.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func heroSelected(id: Int) {
        router.showHeroDetails(id: id)
    }
}
