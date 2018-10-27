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
    
    var catalogues = [Catalogue]() {
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
        return catalogues.count
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
                    strongSelf.catalogues = try decoder.decode([Catalogue].self, from: data)
                } catch {
                    strongSelf.alertMessage = "Can't decode API response"
                }
            }
            
        }
    }
    
    func getNumberOfCells(in section: Int) -> Int {
        guard catalogues.count > 0,
            section < catalogues.count,
            let items = catalogues[section].items
        else { return 0 }
        return items.count
    }
    
    func getItem(in section: Int, at index: Int) -> Item? {
        guard catalogues.count > 0,
            section < catalogues.count,
            let items = catalogues[section].items,
            items.count > 0,
            index < items.count
        else { return nil }
        return items[index]
    }
    
    func getCatalogueTitle(for section: Int) -> String? {
        guard catalogues.count > 0,
            section < catalogues.count
            else { return nil }
        return catalogues[section].category
    }
    
    func arrangeCatalogues() {
        if catalogues.count == 3  {
            var newCatalogues = [Catalogue?]()
            newCatalogues.append(nil)
            newCatalogues.append(nil)
            newCatalogues.append(nil)
            for catalogue in catalogues {
                if catalogue.category?.caseInsensitiveCompare("Features") == .orderedSame {
                    newCatalogues[0] = catalogue
                } else if catalogue.category?.caseInsensitiveCompare("Movies") == .orderedSame {
                    newCatalogues[1] = catalogue
                } else if catalogue.category?.caseInsensitiveCompare("TV Shows") == .orderedSame {
                    newCatalogues[2] = catalogue
                }
            }
            catalogues = newCatalogues as! [Catalogue]
        }
    }
}

