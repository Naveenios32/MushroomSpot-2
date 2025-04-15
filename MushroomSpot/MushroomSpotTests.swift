import XCTest
@testable import MushroomSpot

final class MushroomSpotTests: XCTestCase {

    var viewModel: LoginVM!

    override func setUpWithError() throws {
        viewModel = LoginVM()
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

    func testInvalidPasswordNoSpecialChar() {
        XCTAssertFalse(viewModel.isValidPassword("Abc12345"))
    }

    func testInvalidPasswordNoUppercase() {
        XCTAssertFalse(viewModel.isValidPassword("abc@1234"))
    }
}
