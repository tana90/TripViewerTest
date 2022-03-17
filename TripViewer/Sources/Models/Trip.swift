//
//  Trip.swift
//  TripViewer
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  Created by Tudor Octavian Ana on 10.03.2022.
//

import Foundation

// MARK: Trip struct

struct Trip: Decodable {
    let id: String
    let start, end: String
    let location: Route
    let image: String
    
    var startDate: Date {
        fullDateFormatter.date(from: start) ?? Date()
    }
    
    var endDate: Date {
        fullDateFormatter.date(from: end) ?? Date()
    }
    
    var duration: String? {
        startDate.duration(by: [.hour, .minute], endDate: endDate)
    }
}

// MARK: Trip section used in Trips Screen

struct TripSection {
    var trips: [Trip]
    var date: Date
}
