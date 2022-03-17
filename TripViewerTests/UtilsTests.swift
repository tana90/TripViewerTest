//
//  UtilsTests.swift
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

final class UtilsTest: XCTestCase {
    
    func testSliceComponents() {
        let trips = [
            Trip(id: "0",
                 start: "2022-03-12T00:00:00+00:00",
                 end: "2022-03-12T00:00:00+00:00",
                 location: Route(start: Location(city: "", county: "", country: ""),
                                 end: Location(city: "", county: "", country: "")),
                 image: ""),
            Trip(id: "1",
                 start: "2022-03-12T00:00:00+00:00",
                 end: "2022-03-12T00:00:00+00:00",
                 location: Route(start: Location(city: "", county: "", country: ""),
                                 end: Location(city: "", county: "", country: "")),
                 image: ""),
            Trip(id: "2",
                 start: "2022-03-13T00:00:00+00:00",
                 end: "2022-03-13T00:00:00+00:00",
                 location: Route(start: Location(city: "", county: "", country: ""),
                                 end: Location(city: "", county: "", country: "")),
                 image: "")
        ]
        
        let dic = trips.sliced(by: [.year, .month, .day], for: \.startDate)
        XCTAssertEqual(dic.count, 2)
    }
}
