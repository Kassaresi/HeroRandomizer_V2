//
//  HeroDetailView.swift
//  HeroRandomizerV2
//
//  Created by Alikhan Kassiman on 2025.03.25.
//

import SwiftUI

struct HeroDetailView: View {
    @StateObject var viewModel: HeroDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 200)
                } else if let error = viewModel.errorMessage {
                    errorView(message: error)
                } else if let hero = viewModel.hero {
                    // Hero image
                    heroImage(url: hero.imageUrl)
                    
                    // Basic info
                    VStack(alignment: .leading, spacing: 8) {
                        Text(hero.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        basicInfoText("Race", value: hero.race)
                        basicInfoText("Publisher", value: hero.publisher)
                        basicInfoText("Alignment", value: hero.alignment.capitalized)
                        basicInfoText("Base", value: hero.base)
                    }
                    .padding(.horizontal)
                    
                    // Power stats - simplified to just a list
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Power Stats")
                            .font(.headline)
                            .padding(.top, 8)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            statText("Intelligence", value: hero.intelligence)
                            statText("Strength", value: hero.strength)
                            statText("Speed", value: hero.speed)
                            statText("Durability", value: hero.durability)
                            statText("Power", value: hero.power)
                            statText("Combat", value: hero.combat)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadHeroDetails()
        }
    }
    
    private func heroImage(url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray
        }
        .aspectRatio(16/9, contentMode: .fill)
        .frame(maxWidth: .infinity)
        .clipped()
    }
    
    private func basicInfoText(_ label: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(label + ":")
                .fontWeight(.medium)
                .frame(width: 80, alignment: .leading)
            
            Text(value)
        }
        .font(.subheadline)
    }
    
    private func statText(_ label: String, value: Int) -> some View {
        HStack {
            Text(label + ":")
                .frame(width: 100, alignment: .leading)
            Text("\(value)")
                .fontWeight(.medium)
            Spacer()
        }
        .font(.subheadline)
    }
    
    private func errorView(message: String) -> some View {
        VStack {
            Text(message)
                .foregroundColor(.secondary)
            
            Button("Retry") {
                Task {
                    await viewModel.loadHeroDetails()
                }
            }
            .padding(.top)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
    }
}
