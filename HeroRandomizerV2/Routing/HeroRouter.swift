//
//  HeroRouter.swift
//  HeroRandomizerV2
//
//  Created by Alikhan Kassiman on 2025.03.25.
//

import SwiftUI
import UIKit

class HeroRouter {
    weak var rootNavController: UINavigationController?
    
    func showHeroDetails(id: Int) {
        let heroService = HeroServiceImpl()
        let viewModel = HeroDetailViewModel(heroId: id, service: heroService)
        let detailView = HeroDetailView(viewModel: viewModel)
        let detailVC = UIHostingController(rootView: detailView)
        rootNavController?.pushViewController(detailVC, animated: true)
    }
}
