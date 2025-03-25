//
//  HeroListView.swift
//  HeroRandomizerV2
//
//  Created by Alikhan Kassiman on 2025.03.25.
//

import SwiftUI

struct HeroListView: View {
    @StateObject var viewModel: HeroListViewModel
    
    var body: some View {
        VStack {
            // Title - Larger size
            Text("Heroes")
                .font(.system(size: 36, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)
            
            // Search bar
            TextField("Search heroes", text: $viewModel.searchText)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            // Content
            if viewModel.isLoading && viewModel.heroes.isEmpty {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage, viewModel.heroes.isEmpty {
                errorView(message: error)
            } else if viewModel.heroes.isEmpty {
                Text("No heroes found")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                heroListView
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadHeroes()
        }
    }
    
    private var heroListView: some View {
        List(viewModel.heroes) { hero in
            HeroRow(hero: hero)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.heroSelected(id: hero.id)
                }
        }
        .listStyle(PlainListStyle())
    }
    
    private func errorView(message: String) -> some View {
        VStack {
            Text(message)
                .foregroundColor(.secondary)
            
            Button("Retry") {
                Task {
                    await viewModel.loadHeroes()
                }
            }
            .padding(.top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HeroRow: View {
    let hero: HeroListModel
    
    var body: some View {
        HStack {
            // Hero image
            AsyncImage(url: hero.imageUrl) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Hero details
            VStack(alignment: .leading, spacing: 4) {
                Text(hero.name)
                    .font(.headline)
                
                Text(hero.race)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
