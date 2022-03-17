//
//  Extensions.swift
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

// MARK: Date extension

extension Date {
    
    func duration(by dateComponents: NSCalendar.Unit, endDate: Date) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = dateComponents
        formatter.unitsStyle = .brief
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: self, to: endDate)
    }
}

// MARK: Collection extension

extension Array {
    
    func sliced(by dateComponents: Set<Calendar.Component>,
                for key: KeyPath<Element, Date>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents(dateComponents, from: cur[keyPath: key])
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
        
        return groupedByDateComponents
    }
}

var fullDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter
}()

var shortDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d"
    return dateFormatter
}()

var shortTimeFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter
}()

/// Print line to console
///
/// - Parameters:
///   - object:
///   - filename:
///   - line:
///   - funcname:
///   - isSolo:
func log<T>(_ object: T, filename: String = #file, line: Int = #line, funcname: String = #function,
            isSolo: Bool? = false) {
#if DEBUG
    let className = filename.split {
        $0 == "/"
    }.map(String.init).last
    print("[\(Date()) :: \(className ?? "Unknow class") : \(funcname)(\(line))] - \(object)")
#endif
}
