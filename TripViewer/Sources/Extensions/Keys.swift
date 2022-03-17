//
//  Keys.swift
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

/// Define Cells Identifiers
enum Cell {
    case tripCell
    var identifier: String {
        switch self {
        case .tripCell:
            return "tripCellIdentifier"
        }
    }
    
    var name: String {
        switch self {
        case .tripCell:
            return "TripViewCell"
        }
    }
}

/// Define Segue Identifiers
enum Navigation {
    case tripDetails
    case help
    var segue: String {
        switch self {
        case .tripDetails:
            return "tripDetailsSegue"
        case .help:
            return "helpSegue"
        }
    }
}
