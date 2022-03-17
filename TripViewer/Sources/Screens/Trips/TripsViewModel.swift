//
//  MainViewModel.swift
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

protocol TripsViewModelDelegate: AnyObject {
    typealias ViewModel = TripsViewModel
    func viewModelDidFinish(_ viewModel: ViewModel)
    func viewModel(_ viewModel: ViewModel, didFailWith error: EndpointError)
}

enum SortType {
    case ascending, descending
}

class TripsViewModel {
    
    weak var delegate: TripsViewModelDelegate?
    var observer: AnyCancellable?
    var sortType: SortType = .descending {
        didSet {
            switch sortType {
            case .ascending:
                tripsSections.sort(by: {
                    $0.date < $1.date
                })
            case .descending:
                tripsSections.sort(by: {
                    $0.date > $1.date
                })
            }
            delegate?.viewModelDidFinish(self)
        }
    }
    var tripsSections = [TripSection]()
    
    @objc func fetch() {
        let connector = Connector()
        observer = connector.fetchTrips()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    self.delegate?.viewModelDidFinish(self)
                case .failure(let error):
                    self.delegate?.viewModel(self, didFailWith: error)
                }
            } receiveValue: { [weak self] response in
                self?.tripsSections = self?.group(trips: response.trips,
                                                  by: .day) ?? []
            }
    }
    
    private func group(trips: [Trip],
                       by component: Calendar.Component) -> [TripSection] {
        
        trips.sliced(by: [.year, .month, .day], for: \.startDate)
            .map {
                TripSection(trips: $1, date: $0)
            }
            .sorted(by: {
                $0.date > $1.date
            })
    }
}
