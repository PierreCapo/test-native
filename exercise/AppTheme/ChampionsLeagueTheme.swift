import UIKit

class ChampionsLeagueTheme: CompetitionTheme {
    
    // MARK: Colors
    var backgroundColor: UIColor = UIColor.init(named: "UCLDarkBlue")!
    var accordionHeaderTitleStyle = UIColor.white
    var horizontalStatTitleStyle = UIColor.white
    var circleStrokeBagroundColor = UIColor.white
    var homeTeamColor = UIColor.init(named: "UCLGreen")!
    var awayTeamColor: UIColor = UIColor.init(named: "UCLBlue")!
    var fontColor = UIColor.white
    
    // Mark: Margins
    var s: CGFloat = 4
    var m: CGFloat = 8
    var l: CGFloat = 16
    
    // MARK: Fonts
    var fontSmall = CGFloat(12)
    var fontBig = CGFloat(21)
}
