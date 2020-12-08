import UIKit

class CircleView: UIView {
    init(circleSize: CGFloat, strokeColor: UIColor, startingFraction: CGFloat, endingFraction: CGFloat, strokeWidth: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: circleSize, height: circleSize))
        
        self.layer.cornerRadius = circleSize / 2
        
        // bezier path
        let circlePath = UIBezierPath(arcCenter: CGPoint (x: circleSize / 2, y: circleSize / 2),
                                      radius: circleSize / 2,
                                      startAngle: CGFloat(-0.5 * .pi),
                                      endAngle: CGFloat(1.5 * .pi),
                                      clockwise: true)
        // circle shape
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        circleShape.strokeColor = strokeColor.cgColor
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.lineWidth = strokeWidth
        // set start and end values
        circleShape.strokeStart = startingFraction
        circleShape.strokeEnd = endingFraction
        circleShape.lineCap = .round
        
        layer.addSublayer(circleShape)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
