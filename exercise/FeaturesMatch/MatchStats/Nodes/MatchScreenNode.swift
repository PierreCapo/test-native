import AsyncDisplayKit
import Resolver

protocol MatchStatCellNode: MatchStat {
    var node: ASCellNode { get }
}

class MatchStatsScreenNode: ASDisplayNode {
    @Injected var appTheme: CompetitionTheme
    
    weak var presenter: MatchStatsPresenter!
    let statList = ASTableNode()
    let statListHeader = CGFloat(56)
    
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        style.width = ASDimensionMake("100%")
        style.height = ASDimensionMake("100%")
        backgroundColor = appTheme.backgroundColor
        statList.delegate = self
        statList.dataSource = self
        statList.backgroundColor = .clear
        statList.view.tableFooterView = UIView(frame: CGRect.zero)
        statList.view.separatorStyle = .none
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // TODO: This inset here is used to mock a potential header
        let insets = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        
        return ASInsetLayoutSpec(insets: insets, child: statList)
    }
}

extension MatchStatsScreenNode: ASTableDelegate, ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return presenter.sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return statListHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header \(section)") as? CollapsibleSectionHeaderView ?? CollapsibleSectionHeaderView(reuseIdentifier: "header \(section)", sectionNumber: section)
        header.delegate = self
        var titleAttributes = [NSAttributedString.Key: AnyObject]()
        titleAttributes[.foregroundColor] = appTheme.fontColor
        titleAttributes[.font] = UIFont.systemFont(ofSize: appTheme.fontBig, weight: .bold)
        header.label.attributedText = NSAttributedString(string: presenter.sections[section].name, attributes: titleAttributes)
        header.label.textColor = appTheme.fontColor
        return header
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        let section = presenter.sections[section]
        if section.isCollapsed {
            return 0
        } else {
            return section.matchStats.count
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let stat = presenter.sections[indexPath.section].matchStats[indexPath.row]
        
        if let stat = stat as? MatchStatCellNode {
            return stat.node
        } else {
            return ASCellNode()
        }
    }
    
    func tableNode(_: ASTableNode, willSelectRowAt: IndexPath) -> IndexPath? {
        return nil
    }
    
}

extension MatchStatsScreenNode: CollapsibleSectionHeaderViewDelegate {
    func toggleSection(header: CollapsibleSectionHeaderView, section: Int) {
        let newIsCollapsed = !presenter.sections[section].isCollapsed
        presenter.sections[section].isCollapsed = newIsCollapsed
        self.statList.reloadSections(NSIndexSet(index: section) as IndexSet, with: .fade)
    }
    
}
