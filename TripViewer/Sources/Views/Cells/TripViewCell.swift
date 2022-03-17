//
//  TripViewCell.swift
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
import Kingfisher

// MARK: - UITableViewCell

final class TripViewCell: UITableViewCell {
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var startCityLabel: UILabel!
    @IBOutlet private weak var endCityLabel: UILabel!
    @IBOutlet private weak var startDateLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    var trip: Trip? {
        didSet {
            guard let trip = trip else { return }
    
            let processor = DownsamplingImageProcessor(size: CGSize(width: 66, height: 66))
            coverImageView.kf.indicatorType = .activity
            coverImageView.kf.setImage(with: URL(string: trip.image),
                                       placeholder: UIImage(named: "placeholderImage"),
                                       options: [
                                        KingfisherOptionsInfoItem.processor(processor),
                                        KingfisherOptionsInfoItem.scaleFactor(UIScreen.main.scale),
                                        KingfisherOptionsInfoItem.transition(.fade(0.3)),
                                        KingfisherOptionsInfoItem.cacheOriginalImage
                                       ], completionHandler: { _ in })
            
            startCityLabel.text = trip.location.start.city
            endCityLabel.text = trip.location.end.city
            
            startDateLabel.text = shortTimeFormatter.string(from: trip.startDate)
            durationLabel.text = trip.duration ?? "-"
        }
    }
}
