//
//  UIExtensions.swift
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

// MARK: UIView

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func showBanner(message: String, duration: TimeInterval = 3) {
        
        let textLabel = UILabel()
        textLabel.text = message
        textLabel.textColor = .white
        textLabel.font = .systemFont(ofSize: 15, weight: .regular)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [textLabel])
        stack.backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0)
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alpha = 1.0
        
        self.addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: self.lastBaselineAnchor, constant: 3).isActive = true
        stack.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            stack.removeFromSuperview()
        }
    }
}

// MARK: UIViewController

extension UIViewController {
    func showAlert(with title: String? = nil,
                   message: String? = nil,
                   style: UIAlertController.Style = UIDevice.current.userInterfaceIdiom == .phone ?
                   UIAlertController.Style.actionSheet : UIAlertController.Style.alert,
                   actions: [(String, (UIAlertAction) -> Void)]) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        actions.forEach {
            let action = UIAlertAction(title: $0.0, style: .default, handler: $0.1)
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
