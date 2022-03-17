//
//  ProtocolConformanceTests.swift
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

class ProtocolConformanceTest: XCTestCase {

    var tripsViewController: TripsViewController!
    var tripDetailsViewController: TripDetailsViewController!

    override func setUp() {
        super.setUp()
        self.tripsViewController = TripsViewController()
        self.tripDetailsViewController = TripDetailsViewController()
    }

    func testHasATableView() {
        XCTAssertNotNil(tripsViewController.tableView)
        XCTAssertNotNil(tripDetailsViewController.tableView)
    }

    func testTableViewDelegate() {
        XCTAssertNotNil(tripsViewController.tableView.delegate)
        XCTAssertNotNil(tripDetailsViewController.tableView.delegate)
    }

    func testTableViewDataSource() {
        XCTAssertNotNil(tripsViewController.tableView.dataSource)
        XCTAssertNotNil(tripDetailsViewController.tableView.dataSource)
    }

    func testViewControllerConformsToDelegate() {
        XCTAssertTrue(tripsViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(tripDetailsViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertFalse(tripDetailsViewController.responds(
                        to: #selector(tripDetailsViewController.tableView(_:didSelectRowAt:))
        ))
    }

    func testViewControllerConformsToDataSource() {
        XCTAssertTrue(tripsViewController.conforms(
                        to: UITableViewDataSource.self))
        XCTAssertTrue(tripsViewController.responds(
                        to: #selector(tripsViewController.numberOfSections(in:))))
        XCTAssertTrue(tripsViewController.responds(
                        to: #selector(tripsViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(tripsViewController.responds(
                        to: #selector(tripsViewController.tableView(_:cellForRowAt:))))
        XCTAssertTrue(tripDetailsViewController.conforms(
                        to: UITableViewDataSource.self))
        XCTAssertTrue(tripDetailsViewController.responds(
                        to: #selector(tripDetailsViewController.numberOfSections(in:))))
        XCTAssertTrue(tripDetailsViewController.responds(
                        to: #selector(tripDetailsViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(tripDetailsViewController.responds(
                        to: #selector(tripDetailsViewController.tableView(_:cellForRowAt:))))
    }
}
