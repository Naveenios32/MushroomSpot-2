//
//  MushroomSpotTests.swift
//  MushroomSpotTests
//
//  Created by Apple on 15/04/25.
//
import XCTest
@testable import MushroomSpot

final class MushroomSpotTests: XCTestCase {

    var viewModel: LoginViewModel!

    override func setUpWithError() throws {
        viewModel = LoginViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testValidEmail() {
        XCTAssertTrue(viewModel.isValidEmail("test@example.com"))
    }

    func testInvalidEmail() {
        XCTAssertFalse(viewModel.isValidEmail("plainemail"))
    }

    func testValidPassword() {
        XCTAssertTrue(viewModel.isValidPassword("Abc@1234"))
    }

    func testInvalidPasswordTooShort() {
        XCTAssertFalse(viewModel.isValidPassword("A@1b"))
    }

    func testMushroomDecoding() throws {
        let json = """
        {
            "mushrooms": [
                {
                    "id": "1",
                    "name": "Shiitake",
                    "latin_name": "Lentinula edodes",
                    "profile_picture": "https://example.com/image.jpg"
                }
            ]
        }
        """.data(using: .utf8)!

        let result = try JSONDecoder().decode(MushroomResponse.self, from: json)
        XCTAssertEqual(result.mushrooms.count, 1)
        XCTAssertEqual(result.mushrooms.first?.name, "Shiitake")
    }
}
