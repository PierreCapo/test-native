import AsyncDisplayKit
import Resolver

class SharedPercentageNode: ASCellNode {
    @Injected var appTheme: CompetitionTheme
    
    var titleNode = ASTextNode2()
    var leftNumberNode = ASTextNode2()
    var rightNumberNode = ASTextNode2()
    
    var circleNode: SharedPercentageCircleNode
    
    init(title: String, homeTeamValue: Float, awayTeamValue: Float) {
        circleNode = SharedPercentageCircleNode(ratio: CGFloat(awayTeamValue / 100))
        super.init()
        self.automaticallyManagesSubnodes = true
        
        var titleAttributes = [NSAttributedString.Key: AnyObject]()
        titleAttributes[.foregroundColor] = appTheme.fontColor
        titleAttributes[.font] = UIFont.systemFont(ofSize: 12, weight: .regular)
        titleNode.attributedText = NSAttributedString(string: title, attributes: titleAttributes)
        
        var numberAttributes = [NSAttributedString.Key: AnyObject]()
        numberAttributes[.foregroundColor] = appTheme.fontColor
        numberAttributes[.font] = UIFont.systemFont(ofSize: 21, weight: .medium)
        
        leftNumberNode.attributedText = NSAttributedString(string: homeTeamValue.stringWithoutZeroFraction + "%", attributes: numberAttributes)
        rightNumberNode.attributedText = NSAttributedString(string: awayTeamValue.stringWithoutZeroFraction + "%", attributes: numberAttributes)
        
        backgroundColor = .clear
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let centeredTitle = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: titleNode)
        
        let titleAboveCircleSpec = ASOverlayLayoutSpec(child: circleNode, overlay: centeredTitle)
        
        let mainSpec = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [leftNumberNode, titleAboveCircleSpec, rightNumberNode])
        
        let insets = UIEdgeInsets(top: appTheme.l, left: appTheme.l, bottom: appTheme.l, right: appTheme.l)
        
        let mainSpecWithInsets = ASInsetLayoutSpec(insets: insets, child: mainSpec)
        
        return mainSpecWithInsets
    }
}

class SharedPercentageCircleNode: ASDisplayNode {
    @Injected var appTheme: CompetitionTheme
    
    let circleSize = CGFloat(128)
    let circleStrokeWidth = CGFloat(5)
    let spaceDelta = CGFloat(0.01)
    
    init(ratio: CGFloat){
        super.init()
        style.preferredSize = CGSize(width: circleSize, height: circleSize)
        let homeCircleView = CircleView(circleSize: circleSize, strokeColor: appTheme.awayTeamColor, startingFraction: spaceDelta, endingFraction: ratio - spaceDelta, strokeWidth: circleStrokeWidth)
        
        let awayCircleView = CircleView(circleSize: circleSize, strokeColor: appTheme.homeTeamColor, startingFraction: ratio + spaceDelta, endingFraction: 1.0 - spaceDelta, strokeWidth: circleStrokeWidth)
        
        self.view.addSubview(homeCircleView)
        self.view.addSubview(awayCircleView)
        
    }
}

