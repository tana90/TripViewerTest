//
//  Endpoint.swift
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
import AWNetworkManager

/// Defines URLs

enum Endpoint: AWEndpoint {
    case trips
}

extension Endpoint {
    
    static var baseUrl = "https://autoliv.github.io"
    
    var url: URL {
        switch self {
        case .trips:
            return URL(string: Self.baseUrl + "/interview-data.json")!
        }
    }
    
    var request: URLRequest {
        switch self {
        case .trips:
            return URLRequest(url: Self.trips.url, timeoutInterval: 30)
        }
    }
    
    var body: Data? { return nil }
}
