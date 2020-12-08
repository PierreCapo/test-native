import AsyncDisplayKit
import Resolver

class DistinctPercentageNode: ASCellNode {
    @Injected var appTheme: CompetitionTheme
    
    var titleNode = ASTextNode2()
    var leftNumberNode = ASTextNode2()
    var rightNumberNode = ASTextNode2()
    
    var circleHomeNode: DistinctPercentageCircleNode
    var circleAwayNode: DistinctPercentageCircleNode
    
    init(title: String, homeTeamValue: Float, awayTeamValue: Float) {
        circleHomeNode = DistinctPercentageCircleNode(ratio: CGFloat(homeTeamValue / 100), teamSide: .homeTeam)
        circleAwayNode = DistinctPercentageCircleNode(ratio: CGFloat(awayTeamValue / 100), teamSide: .awayTeam)
        
        super.init()
        self.automaticallyManagesSubnodes = true
        
        var titleAttributes = [NSAttributedString.Key: AnyObject]()
        titleAttributes[.foregroundColor] = appTheme.fontColor
        titleAttributes[.font] = UIFont.systemFont(ofSize: appTheme.fontSmall, weight: .regular)
        titleNode.attributedText = NSAttributedString(string: title, attributes: titleAttributes)
        
        var numberAttributes = [NSAttributedString.Key: AnyObject]()
        numberAttributes[.foregroundColor] = appTheme.fontColor
        numberAttributes[.font] = UIFont.systemFont(ofSize: appTheme.fontBig, weight: .medium)
        
        leftNumberNode.attributedText = NSAttributedString(string: (homeTeamValue.stringWithoutZeroFraction) + "%", attributes: numberAttributes)
        rightNumberNode.attributedText = NSAttributedString(string: (awayTeamValue.stringWithoutZeroFraction) + "%", attributes: numberAttributes)
        
        backgroundColor = .clear
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let centeredHomeTitle = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: leftNumberNode)
        
        let homeCircleWithTextSpec = ASOverlayLayoutSpec(child: circleHomeNode, overlay: centeredHomeTitle)
        
        let centeredAwayTitle = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: rightNumberNode)
        
        let awayCircleWithTextSpec = ASOverlayLayoutSpec(child: circleAwayNode, overlay: centeredAwayTitle)
        
        let mainSpec = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [homeCircleWithTextSpec, titleNode, awayCircleWithTextSpec])
        
        let insets = UIEdgeInsets(top: appTheme.l, left: appTheme.l, bottom: appTheme.l, right: appTheme.l)
        
        let mainSpecWithInsets = ASInsetLayoutSpec(insets: insets, child: mainSpec)
        
        return mainSpecWithInsets
    }
}

class DistinctPercentageCircleNode: ASDisplayNode {
    @Injected var appTheme: CompetitionTheme
    
    var circleSize = CGFloat(68)
    var circleStrokeWidth = CGFloat(3)
    
    let spaceDelta = CGFloat(0.01)
    
    init(ratio: CGFloat, teamSide: TeamSide){
        super.init()
        style.preferredSize = CGSize(width: circleSize, height: circleSize)
        
        let backgroundCircleView = CircleView(
            circleSize: circleSize,
            strokeColor: appTheme.circleStrokeBagroundColor.withAlphaComponent(0.15),
            startingFraction: 0.0,
            endingFraction: 1.0,
            strokeWidth: circleStrokeWidth)
        
        let frontCircleView = CircleView(
            circleSize: circleSize,
            strokeColor: teamSide.teamColor,
            startingFraction: 0.0,
            endingFraction: ratio,
            strokeWidth: circleStrokeWidth)
        
        self.view.addSubview(backgroundCircleView)
        self.view.addSubview(frontCircleView)
    }
}

extension DistinctPercentageMatchStat: MatchStatCellNode {
    var node: ASCellNode {
        let cellNode: ASCellNode = DistinctPercentageNode(title: self.title, homeTeamValue: self.homeTeamValue, awayTeamValue: self.awayTeamValue)
        return cellNode
    }
}
