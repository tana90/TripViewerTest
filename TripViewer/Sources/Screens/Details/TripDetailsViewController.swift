//
//  TripDetailsViewController.swift
//  TripViewer
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  Created by Tudor Octavian Ana on 12.03.2022.
//

import UIKit
import Kingfisher

final class TripDetailsViewController: UITableViewController {
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var startCountryLabel: UILabel!
    @IBOutlet private weak var startCityLabel: UILabel!
    @IBOutlet private weak var endCountryLabel: UILabel!
    @IBOutlet private weak var endCityLabel: UILabel!
    @IBOutlet private weak var startDateLabel: UILabel!
    @IBOutlet private weak var startTimeLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!
    @IBOutlet private weak var endTimeLabel: UILabel!
    
    var viewModel: TripDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let trip = viewModel?.trip {
            updateUI(from: trip)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func updateUI(from trip: Trip) {
        coverImageView.kf.setImage(with: URL(string: trip.image),
                                   placeholder: UIImage(named: "placeholderImage"),
                                   options: [
                                    KingfisherOptionsInfoItem.cacheOriginalImage
                                   ], completionHandler: { _ in })
     
        startCountryLabel.text = trip.location.start.country
        startCityLabel.text = trip.location.start.city
        
        endCountryLabel.text = trip.location.end.country
        endCityLabel.text = trip.location.end.city
        
        startDateLabel.text = shortDateFormatter.string(from: trip.startDate)
        startTimeLabel.text = shortTimeFormatter.string(from: trip.startDate)
        
        endDateLabel.text = shortDateFormatter.string(from: trip.endDate)
        endTimeLabel.text = shortTimeFormatter.string(from: trip.endDate)
    }
}

extension TripDetailsViewController {
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            return "Duration " + (viewModel?.trip.duration ?? "-")
        }
        return nil
    }
}
