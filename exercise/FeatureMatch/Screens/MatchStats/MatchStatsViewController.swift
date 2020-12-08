import AsyncDisplayKit
import Resolver

class MatchStatsViewController: ASDKViewController<ASDisplayNode> {
    @Injected var presenter: MatchStatsPresenter
    
    override init() {
        let node = MatchStatsScreenNode()
        super.init(node: node)
        node.presenter = presenter
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
