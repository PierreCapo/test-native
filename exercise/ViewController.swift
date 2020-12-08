import AsyncDisplayKit
import CollapsibleTableSectionViewController

protocol ViewInput: class {
    
}

class ViewController: ASDKViewController<ASDisplayNode>, ViewInput {
    
    override init() {
        super.init(node: ASDisplayNode())
        view.backgroundColor = .yellow
        print("hello world")
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
