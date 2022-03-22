//
//  ValidationService.swift
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

import UIKit

struct ValidationService {

    /// Validate URL
    /// - Parameter codePairs: Currency code pairs like 'GBPUSD'
    /// - Throws: EndpointError
    /// - Returns: Valid URL
    func url(from urlString: String) throws -> URL {
        
        guard let url = URL(string: urlString),
              UIApplication.shared.canOpenURL(url) else {
                  throw EndpointError.invalidUrl
              }
        
        return url
    }

    /// Validate API Response
    /// - Parameter data
    /// - Throws: EndpointError
    /// - Returns: Valid response
    func response<T: Decodable>(data: Data?) throws -> T {
        
        // Check if we have data to parse
        guard let data = data else {
            throw EndpointError.noData
        }
        
        // Try to parse response
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw EndpointError.invalidResponse
        }
    }
}
