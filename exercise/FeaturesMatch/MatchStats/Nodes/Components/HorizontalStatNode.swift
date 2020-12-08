import AsyncDisplayKit
import Resolver

class HorizontalStatNode: ASCellNode {
    @Injected var appTheme: CompetitionTheme
    
    var titleNode = ASTextNode2()
    var leftNumberNode = ASTextNode2()
    var rightNumberNode = ASTextNode2()
    var leftLine: HorizontalStatLineNode
    var rightLine: HorizontalStatLineNode
    
    
    init(title: String, homeTeamValue: Float, awayTeamValue: Float) {
        leftLine = HorizontalStatLineNode(teamSide: .homeTeam, flexValue: homeTeamValue)
        rightLine = HorizontalStatLineNode(teamSide: .awayTeam, flexValue: awayTeamValue)
        super.init()
        self.automaticallyManagesSubnodes = true
        
        var titleAttributes = [NSAttributedString.Key: AnyObject]()
        titleAttributes[.foregroundColor] = appTheme.fontColor
        titleAttributes[.font] = UIFont.systemFont(ofSize: appTheme.fontSmall, weight: .regular)
        titleNode.attributedText = NSAttributedString(string: title, attributes: titleAttributes)
        
        var numberAttributes = [NSAttributedString.Key: AnyObject]()
        numberAttributes[.foregroundColor] = appTheme.fontColor
        numberAttributes[.font] = UIFont.systemFont(ofSize: appTheme.fontBig, weight: .medium)
        
        leftNumberNode.attributedText = NSAttributedString(string: homeTeamValue.stringWithoutZeroFraction, attributes: numberAttributes)
        rightNumberNode.attributedText = NSAttributedString(string: awayTeamValue.stringWithoutZeroFraction, attributes: numberAttributes)
        
        style.width = ASDimensionMake("100%")
        backgroundColor = .clear
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let firstline = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [leftNumberNode, titleNode, rightNumberNode]
        )
        firstline.style.width = ASDimensionMake("100%")
        
        let secondLine = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 4,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [leftLine, rightLine]
        )
        secondLine.style.width = ASDimensionMake("100%")
        
        let mainSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 18,
            justifyContent: .start,
            alignItems: .start,
            children: [firstline, secondLine])
        
        let insets = UIEdgeInsets(top: appTheme.l, left: appTheme.l, bottom: appTheme.l, right: appTheme.l)
        
        let mainSpecWithInsets = ASInsetLayoutSpec(insets: insets, child: mainSpec)
        
        return mainSpecWithInsets
        
    }
    
}

class HorizontalStatLineNode: ASDisplayNode {
    @Injected var appTheme: CompetitionTheme
    
    init(teamSide: TeamSide, flexValue: Float) {
        super.init()
        style.preferredSize = CGSize(width: 0, height: 2)
        
        // TODO: Some edge case to consider here
        // What should be the design if both stat values equals to 0 ?
        style.flexGrow = CGFloat(flexValue)
        self.backgroundColor = teamSide.teamColor
        cornerRadius = 1
    }
}
