import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

extension UIViewController {
    func startAnimation() {
        let activityData = ActivityData(type: .circleStrokeSpin)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func stopAnimation() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
