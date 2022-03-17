//
//  TripsViewController.swift
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
import Combine

// MARK: - UITableViewController

final class TripsViewController: UITableViewController {
    
    lazy var viewModel: TripsViewModel = {
        let viewModel = TripsViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start to fetch data
        viewModel.fetch()
        
        // Setup TableView
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(viewModel, action: #selector(TripsViewModel.fetch),
                                            for: .valueChanged)
        tableView.register(UINib(nibName: Cell.tripCell.name, bundle: nil),
                           forCellReuseIdentifier: Cell.tripCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tripDetailsViewController = segue.destination as? TripDetailsViewController,
           let viewModel = sender as? TripDetailsViewModel {
            tripDetailsViewController.viewModel = viewModel
        }
    }
}

// MARK: Actions

extension TripsViewController {
    
    @IBAction private func helpAction() {
        performSegue(withIdentifier: Navigation.help.segue, sender: nil)
    }
    
    @IBAction private func sortAction() {
        let alertController = UIAlertController(title: APPNAME,
                                                message: NSLocalizedString("Sort items in the list in ascending or descending order",
                                                                           comment: String()),
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Ascending", comment: String()),
                                                style: .default, handler: { [unowned self] _ in
            self.viewModel.sortType = .ascending
        }))
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Descending", comment: String()),
                                                style: .default, handler: { [unowned self] _ in
            self.viewModel.sortType = .descending
        }))
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: String()),
                                                style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: ViewModel Delegate

extension TripsViewController: TripsViewModelDelegate {
    func viewModelDidFinish(_ viewModel: ViewModel) {
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func viewModel(_ viewModel: ViewModel, didFailWith error: EndpointError) {
        tableView.refreshControl?.endRefreshing()
        view.showBanner(message: error.localizedDescription)
    }
}

// MARK: UITableViewDataSource

extension TripsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let sectionCount = viewModel.tripsSections.count
        (tableView as? InfoLoadingTableView)?.showEmptyInfo(sectionCount == 0)
        return sectionCount
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        shortDateFormatter.string(from: viewModel.tripsSections[section].date)
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        viewModel.tripsSections[section].trips.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.tripCell.identifier,
                                                       for: indexPath) as? TripViewCell else { fatalError() }
        cell.trip = viewModel.tripsSections[indexPath.section].trips[indexPath.row]
        return cell
    }
}

// MARK: UITableViewDelegate

extension TripsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = viewModel.tripsSections[indexPath.section].trips[indexPath.row]
        performSegue(withIdentifier: Navigation.tripDetails.segue,
                     sender: TripDetailsViewModel(with: trip))
    }
}
