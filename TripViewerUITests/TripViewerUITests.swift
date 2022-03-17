//
//  TripViewerUITests.swift
//  TripViewerUITests
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  Created by Tudor Octavian Ana on 10.03.2022.
//

import XCTest

class TripViewerUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testFlow() throws {
        app.buttons["sortButtonIdentifier"].tap()
        app.sheets["Trip Viewer"].buttons["Ascending"].tap()
        app.tables["tripTableIdentifier"].cells.element(boundBy: 0).swipeUp()
        app.tables["tripTableIdentifier"].cells.element(boundBy: 4).tap()
        
        app.navigationBars.buttons.firstMatch.tap()
    }
}
