//
//  Errors.swift
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

// MARK: Error protocol

enum EndpointError: Error, Equatable {
    case invalidResponse
    case noData
    case invalidUrl
    case noConnection
    case unexpected(code: Int)

    var message: String? {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("Invalid response.", comment: String())
        case .noData:
            return NSLocalizedString("No data received.", comment: String())
        case .invalidUrl:
            return NSLocalizedString("Unable to create URL.", comment: String())
        case .noConnection:
            return NSLocalizedString("No internet connection.", comment: String())
        case .unexpected:
            return NSLocalizedString("An unexpected error occurred.", comment: String())
        }
    }
}
