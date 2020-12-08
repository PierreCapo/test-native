import UIKit

protocol CompetitionTheme {
    
    // MARK: Colors
    var backgroundColor: UIColor { get }
    var accordionHeaderTitleStyle: UIColor { get }
    var homeTeamColor: UIColor { get }
    var awayTeamColor: UIColor { get }
    var fontColor: UIColor { get }
    var circleStrokeBagroundColor: UIColor { get }
    
    
    // MARK: Margins
    var s: CGFloat { get set }
    var m: CGFloat { get set }
    var l: CGFloat { get set }
    
    // MARK: Fonts
    var fontSmall: CGFloat { get set }
    var fontBig: CGFloat { get set }
}
