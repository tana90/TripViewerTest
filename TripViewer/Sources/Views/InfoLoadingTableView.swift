//
//  InfoLoadingTableView.swift
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

// MARK: UITableView

class InfoLoadingTableView: UITableView {

    // Prepare an info to show when the table has no data
    lazy private var emptyInfoStackView: UIStackView = {
        
        let activitySpinner = UIActivityIndicatorView(style: .medium)
        activitySpinner.hidesWhenStopped = false
        activitySpinner.startAnimating()

        let descriptionLabel = UILabel()
        descriptionLabel.text = NSLocalizedString("Loading...", comment: String())
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.alpha = 0.5

        let stack = UIStackView(arrangedSubviews: [activitySpinner, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alpha = 0.0

        self.backgroundView = stack
        stack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -66).isActive = true

        return stack
    }()

    func showEmptyInfo(_ status: Bool) {
        emptyInfoStackView.alpha = status ? 1.0 : 0.0
    }
}
