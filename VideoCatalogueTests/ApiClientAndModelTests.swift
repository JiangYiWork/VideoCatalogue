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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testVideoCatalogueApiService() {
        let apiClient = ApiClient()
        apiClient.networkRequest(.videoCatalogue
            , completionHandler: { (data, error) in
                guard let data = data else {
                    print("Error: \(error.debugDescription)")
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
        })
    }
    
    func testVideoCatalogueModelWithCorrectMockData() {
        let apiClient = MockApiClient()
        apiClient.jsonFileName = .vcResponse_correct
        apiClient.networkRequest(.videoCatalogue) { (data, error) in
            XCTAssertTrue(data != nil)
            if let data = data {
                let decoder = JSONDecoder()
                let model = try! decoder.decode([Catalogue].self, from: data)
                XCTAssertTrue(model.count > 0)
                dump(model)
            } else {
                if let error = error {
                    print("Error: \(error)")
                }
                XCTAssert(error == nil, "The Mock Data should be all right. But not here!")
            }
        }
        
    }
    
    func testVideoCatalogueModelWithEmptyMockData() {
        let apiClient = MockApiClient()
        apiClient.jsonFileName = .vcResponse_empty
        apiClient.networkRequest(.videoCatalogue) { (data, error) in
            if let data = data {
                let decoder = JSONDecoder()
                let model = try! decoder.decode([Catalogue].self, from: data)
                XCTAssertTrue(model.count == 0)
                dump(model)
            } else {
                if let error = error {
                    print("Error: \(error)")
                }
            }
        }
        
    }

}


class MockApiClient: ApiClient {
    
    enum JsonFileName: String {
        case vcResponse_correct = "VideoCatalogueAPIResponse"
        case vcResponse_empty = "VideoCatalogueAPIResponse_empty"
        case vcResponse_incorrect = "VideoCatalogueAPIResponse_incorrect"
    }
    
    var jsonFileName: JsonFileName = .vcResponse_correct
    
    //Use mock response data
    override func networkRequest(_ config: ApiConfig, completionHandler: @escaping ((Data?, RequestError?) -> Void)) {
        guard let jsonData = JsonFileLoader.loadJson(fileName: jsonFileName.rawValue) else {
            completionHandler(nil, RequestError("Video Catalogue information failed."))
            return
        }
        completionHandler(jsonData, nil)
    }
}

class JsonFileLoader {
    
    class func loadJson(fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                return try NSData(contentsOf: url) as Data
            } catch let error {
                print("Error!! Unable to parse  \(fileName).json\n error: \(error)")
            }
            print("Error!! Unable to load  \(fileName).json")
        } else {
            print("invalid url")
        }
        return nil
    }
}
