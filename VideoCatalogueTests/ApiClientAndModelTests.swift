//
//  ApiClientAndModelTests.swift
//  ApiClientAndModelTests
//
//  Created by Yi JIANG on 24/10/18.
//  Copyright © 2018 Siphty. All rights reserved.
//

import XCTest
@testable import VideoCatalogue

class ApiClientAndModelTests: XCTestCase {

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

    func testVideoCatalogueApiService() {
        #warning("TODO: 🚧👷🏻‍♂️Yi: Refactor based on format 🚧")
        mockApiClient.networkRequest(.videoCatalogue) { (data, error) in
            guard error != nil else {
                print("Error: \(error.debugDescription)")
                return
            }
            guard let data = data else {
                XCTFail()
                return
            }
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode([Catalogue].self, from: data)
                XCTAssertTrue(model.count > 0)
                dump(model)
            } catch {
                XCTFail()
            }
        }
    }
    
    func testVideoCatalogueModelWithCorrectMockData() {
        #warning("TODO: 🚧👷🏻‍♂️Yi: Refactor based on format 🚧")
        mockApiClient.jsonFileName = .vcResponse_correct
        mockApiClient.networkRequest(.videoCatalogue) { (data, error) in
            XCTAssertTrue(data != nil)
            if let error = error {
                if let data = data {
                    let decoder = JSONDecoder()
                    let model = try! decoder.decode([Catalogue].self, from: data)
                    XCTAssertTrue(model.count > 0)
                    dump(model)
                } else {
                        print("Error: \(error)")
                    }
            } else {
                XCTAssert(error == nil, "The Mock Data should be all right. But not here!")
            }
        }
    }
    
    func testVideoCatalogueModelWithEmptyMockData() {
        #warning("TODO: 🚧👷🏻‍♂️Yi: Refactor based on format 🚧")
        mockApiClient.jsonFileName = .vcResponse_empty
        mockApiClient.networkRequest(.videoCatalogue) { (data, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                if let data = data {
                    let decoder = JSONDecoder()
                    let model = try! decoder.decode([Catalogue].self, from: data)
                    XCTAssertTrue(model.count == 0)
                    dump(model)
                } else {
                    XCTFail()
                }
            }
        }
        
    }

}


