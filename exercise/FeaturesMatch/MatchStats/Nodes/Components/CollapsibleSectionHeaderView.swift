import UIKit
import Resolver

protocol CollapsibleSectionHeaderViewDelegate {
    func toggleSection(header: CollapsibleSectionHeaderView, section: Int)
}

class CollapsibleSectionHeaderView: UITableViewHeaderFooterView {
    @Injected var appTheme: CompetitionTheme
    
    var delegate: CollapsibleSectionHeaderViewDelegate?
    var section: Int
    
    lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(reuseIdentifier: String?, sectionNumber: Int) {
        self.section = sectionNumber
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.tintColor = appTheme.backgroundColor
        
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapHeader(gestureRecognizer:)))
        self.addGestureRecognizer(recognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let views = ["label": label]
        
        let horizontalConstraintVisual = "H:|-16-[label]-16-|"
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: horizontalConstraintVisual, options: [], metrics: nil, views: views)
        contentView.addConstraints(horizontalConstraints)
        
        let verticalConstraintVisual = "V:|-[label]-|"
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: verticalConstraintVisual, options: [], metrics: nil, views: views)
        contentView.addConstraints(verticalConstraints)
    }
    
    @objc
    func tapHeader(gestureRecognizer: UITapGestureRecognizer) {
        guard let header = gestureRecognizer.view as? CollapsibleSectionHeaderView else {
            return
        }
        delegate?.toggleSection(header: header, section: header.section)
    }
    
    
}
