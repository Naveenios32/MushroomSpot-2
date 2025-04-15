//
//  HomeViewModel.swift
//  MushroomSpot
//
//  Created by Apple on 14/04/25.
//
import Foundation

import Foundation

class HomeViewModel {
    var mushrooms: [Mushroom] = []

    var onDataLoaded: (() -> Void)?
    var onError: ((String) -> Void)?

    func fetchMushrooms() {
        mushrooms.removeAll()

        guard let url = URL(string: "http://demo5845085.mockable.io/api/v1/mushrooms") else {
            onError?("Invalid URL")
            return
        }

        APIService.request(url: url, method: .get) { [weak self] (result: Result<MushroomResponse, Error>) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                self.mushrooms = response.mushrooms
                print("✅ Got \(response.mushrooms.count) mushrooms")
                self.onDataLoaded?()
            case .failure(let error):
                print("❌ Failed to load mushrooms:", error.localizedDescription)
                self.onError?("Failed to load mushrooms")
            }
        }
    }

    func mushroom(at index: Int) -> Mushroom {
        return mushrooms[index]
    }

    var count: Int {
        return mushrooms.count
    }
}
