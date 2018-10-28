//
//  CatalogueViewModelTests.swift
//  VideoCatalogueTests
//
//  Created by Yi JIANG on 29/10/18.
//  Copyright © 2018 Siphty. All rights reserved.
//

import XCTest

class CatalogueViewModelTests: XCTestCase {
    
    var catalogueViewModel: CatalogueViewModel!
    var mockApiClient: MockApiClient!

    override func setUp() {
        super.setUp()
        mockApiClient = MockApiClient()
        catalogueViewModel = CatalogueViewModel(mockApiClient)
    }

    override func tearDown() {
        catalogueViewModel = nil
        mockApiClient = nil
        super.tearDown()
    }

    func testFetchCatalogue() {
        #warning("TODO: 🚧👷🏻‍♂️Yi: Test fetch catalogue🚧")

        // Given
        
        // When
        
        // Assert
    }
    
    func testFetchCatalogueFail() {
        #warning("TODO: 🚧👷🏻‍♂️Yi: Test Fetch Catalogue Fail🚧")
        
        // Given
        
        // When
        
        // Assert
    }
    
    func testRearrangeCatalogueArray() {
        #warning("TODO: 🚧👷🏻‍♂️Yi: Test Rearrange Catalogue Array🚧")
        
        // Given
        
        // When
        
        // Assert
    }
    
    func testLoadingWhenFetching() {
        #warning("TODO: 🚧👷🏻‍♂️Yi: Test Loading When Fetching🚧")
        
        // Given
        
        // When
        
        // Assert
    }

}
