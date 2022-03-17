//
//  ConnectorTests.swift
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
import Combine

final class ConnectorTests: XCTestCase {
    
    var publisher: AnyCancellable?
    
    func testRequestResponse() throws {
        
        let finishExpectations = expectation(description: "Finish request")
        let connector = Connector()
        var finalCompletion: Subscribers.Completion<EndpointError>?
        
        publisher = connector.fetchTrips()
            .sink { completion in
                finalCompletion = completion
                finishExpectations.fulfill()
            } receiveValue: { _ in }
        
        wait(for: [finishExpectations], timeout: 30.0)
        
        switch finalCompletion {
        case .finished:
            XCTAssertTrue(true)
        case .failure(let error):
            XCTAssertNotNil(error)
        case .none:
            XCTAssertTrue(false)
        }

    }
}
