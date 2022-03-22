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

class Connector<T: Decodable> {
    
    var observer: AnyCancellable?
    
    func fetch(from endpoint: Endpoint = .trips,
               validatedBy validationService: ValidationService = .init()) -> Future<T, Error> {
        
        Future { [weak self] promise in
            self?.observer = AWNetworkManager<T>().call(endpoint: endpoint)
                .sink { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { value in
                    promise(.success(value))
                }
        }
    }
}
