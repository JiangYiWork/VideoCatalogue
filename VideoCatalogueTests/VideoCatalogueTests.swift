//
//  VideoCatalogueTests.swift
//  VideoCatalogueTests
//
//  Created by Yi JIANG on 24/10/18.
//  Copyright © 2018 Siphty. All rights reserved.
//

import XCTest
@testable import VideoCatalogue

class VideoCatalogueTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testVideoCatalogueApiServiceWithCorrectApi() {
        let apiClient = ApiClient()
        self.measure {
            apiClient.networkRequest(.videoCatalogue
                , completionHandler: { (data, error) in
                    guard let data = data else {
                        print("Error: \(error)")
                        return
                    }
                    
            })
        }
    }
    
    func testVideoCatalogueModelBasedOnMockData() {
        
    }

}


class MockApiClient: ApiClient {
    
    enum JsonFileName: String {
        case vcResponse = "VideoCatalogueAPIResponse"
        case vcResponse_empty = "VideoCatalogueAPIResponse_empty"
    }
    
    var jsonFileName = JsonFileName.vcResponse
    
    //Use mock response data
    override func networkRequest(_ config: ApiConfig, completionHandler: @escaping ((Data?, RequestError?) -> Void)) {
        guard let json = JsonFileLoader.loadJson(fileName: jsonFileName.rawValue) as? Data else {
            completionHandler(nil, RequestError("Video Catalogue information failed."))
            return
        }
        completionHandler(json, nil)
    }
}

class JsonFileLoader {
    
    class func loadJson(fileName: String) -> Any? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            if let data = NSData(contentsOf: url) {
                do {
                    return try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions(rawValue: 0))
                } catch {
                    print("Error!! Unable to parse  \(fileName).json")
                }
            }
            print("Error!! Unable to load  \(fileName).json")
        } else {
            print("invalid url")
        }
        return nil
    }
}
