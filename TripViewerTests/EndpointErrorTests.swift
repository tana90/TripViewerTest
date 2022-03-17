//
//  EndpointErrorTest.swift
//  TripViewerTests
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  Created by Tudor Octavian Ana on 14.03.2022.
//

@testable import TripViewer
import XCTest

final class EndpointErrorTests: XCTestCase {
    var validationService: ValidationService?
    
    override func setUp() {
        super.setUp()
        validationService = ValidationService()
    }
    
    override func tearDown() {
        validationService = nil
        super.tearDown()
    }
    
    func testInvalidUrl() throws {
        let invalidUrlString = "test.com.test"
        XCTAssertThrowsError(try validationService?.url(from: invalidUrlString),
                             "An invalid url error should be thrown") { error in
            guard let endpointError = error as? EndpointError else {
                XCTFail("Unable to convert error: \(error)")
                return
            }
            
            XCTAssertEqual(endpointError, EndpointError.invalidUrl)
        }
    }
    
    func testUnitializedResponse() throws {
        let uninitializedResponse: Data? = nil
        XCTAssertThrowsError(try validationService?.response(data: uninitializedResponse),
                             "An invalidRespose error should be thrown") { error in
            guard let endpointError = error as? EndpointError else {
                XCTFail("Unable to convert error: \(error)")
                return
            }
            XCTAssertEqual(endpointError, EndpointError.noData)
        }
    }
    
    func testEmptyResponse() throws {
        let emptyResponse: Data? = Data()
        XCTAssertThrowsError(try validationService?.response(data: emptyResponse),
                             "An invalidRespose error should be thrown") { error in
            guard let endpointError = error as? EndpointError else {
                XCTFail("Unable to convert error: \(error)")
                return
            }
            XCTAssertEqual(endpointError, EndpointError.invalidResponse)
        }
    }
    
    func testInvalidResponse() throws {
        let invalidResponse = "{\"data\": \"test\"}".data(using: .utf8)
        XCTAssertThrowsError(try validationService?.response(data: invalidResponse),
                             "An invalidRespose error should be thrown") { error in
            guard let endpointError = error as? EndpointError else {
                XCTFail("Unable to convert error: \(error)")
                return
            }
            XCTAssertEqual(endpointError, EndpointError.invalidResponse)
        }
    }
}
