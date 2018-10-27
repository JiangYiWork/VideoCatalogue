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
    
    private var catalogue = [Category]() {
        didSet {
            self.didUpdateCatalogue?()
        }
    }
    
    private var isLoading = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    // MARK: - TableView
    var numberOfSections: Int {
        return catalogue.count
    }
    
    // MARK: - Events
    var didError: ((RequestError) -> Void)?
    var isUpdatingModel: (() -> Void)?
    var didUpdateCatalogue: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var showAlert: (() -> Void)?
    
    init(_ apiClient: ApiClient = ApiClient()) {
        self.apiClient = apiClient
    }
    
    func get
}
