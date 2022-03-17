//
//  Connector.swift
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
import Combine
import AWNetworkManager

// MARK: API Connector

class Connector {
    
    /// Fetch trips from API
    func fetchTrips() -> Future<TripsResponse, EndpointError> {
        Future { promise in
            
            // Validate URL
            guard let url = try? ValidationService().url(from: Urls.trips.uri) else {
                promise(.failure(.invalidUrl))
                return
            }

            // Start request
            var request = URLRequest(url: url)
            request.timeoutInterval = 30
            AWNetworkManager.begin(request) { result in
                
                switch result {
                case .success(let data):

                    do {
                        promise(.success(try ValidationService().response(data: data)))
                    } catch {
                        promise(.failure(.invalidResponse))
                    }
                    
                case .failure(let error):
                    
                    guard let error = error as? EndpointError else {
                        promise(.failure(EndpointError.unexpected(code: 0)))
                        print("Error: \(error)")
                        return
                    }
                    
                    promise(.failure(error))
                }
            }
        }
    }
}
