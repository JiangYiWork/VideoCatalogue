//
//  CatalogueViewModel.swift
//  VideoCatalogue
//
//  Created by Yi JIANG on 26/10/18.
//  Copyright © 2018 Siphty. All rights reserved.
//

import Foundation

class CatalogueViewModel {
    
    let apiClient: ApiClient
    
    var catalogue = [Catalogue]() {
        didSet {
            didUpdateCatalogue?()
        }
    }
    
    var isLoading = false {
        didSet {
            updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            showAlert?()
        }
    }
    
    // MARK: - TableView
    var numberOfSections: Int {
        return catalogue.count
    }
    
    // MARK: - Events
    var hasError: ((RequestError) -> Void)?
    var didUpdateCatalogue: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var showAlert: (() -> Void)?
    
    init(_ apiClient: ApiClient = ApiClient()) {
        self.apiClient = apiClient
    }
    
    func fetchCatalogue() {
        isLoading = true
        apiClient.networkRequest(.videoCatalogue) { [weak self] (data, error) in
            guard let strongSelf = self else { return }
            strongSelf.isLoading = false
            if let error = error {
                strongSelf.hasError?(error)
                strongSelf.alertMessage = error.errorDescription
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    strongSelf.catalogue = try decoder.decode([Catalogue].self, from: data)
                } catch {
                    strongSelf.alertMessage = "Can't decode API response"
                }
            }
            
        }
    }
    
    func getNumberOfCells(in section: Int) -> Int {
        guard catalogue.count > 0,
            section < catalogue.count,
            let items = catalogue[section].items
        else { return 0 }
        return items.count
    }
    
    func getItem(in section: Int, at index: Int) -> Item? {
        guard catalogue.count > 0,
            section < catalogue.count,
            let items = catalogue[section].items,
            items.count > 0,
            index < items.count
        else { return nil }
        return items[index]
    }
    
    func getCatalogueTitle(for section: Int) -> String? {
        guard catalogue.count > 0,
            section < catalogue.count
            else { return nil }
        return catalogue[section].category
    }
    
}
