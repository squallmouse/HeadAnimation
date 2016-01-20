//
//  HeadAnimationView.swift
//  头像动画swift
//
//  Created by 袁昊 on 16/1/14.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class HeadAnimationView: UIImageView {
    
    var coverView: UIView!;
    var radius : CGFloat!;
//    var selfbound:CGRect!;
    var tempLayer : CALayer!;
    init(frame: CGRect , andImage theimage:UIImage ) {
        super.init(frame: frame);
        self.layer.contents = theimage.CGImage;

        coverView = UIView(frame: self.bounds);

        radius = self.bounds.size.width / 3;
    }
    
   required init?(coder aDecoder: NSCoder) {

    super.init(coder: aDecoder);
   }
    
    override func awakeFromNib() {
        coverView = UIView(frame: self.bounds);
        radius = self.bounds.size.width / 3;
        self .headAnimationBegin(4);
    }
    
    func headAnimationBegin(seconds:NSTimeInterval){
        let test1 = UIBezierPath();
        let test2 = UIBezierPath();
        
/*1*/
        test1.addArcWithCenter(CGPointMake(0 ,0 ), radius: radius, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: false);
        
        let shapeLayer = CAShapeLayer();
        shapeLayer.path = test1.CGPath;
        shapeLayer.fillColor = UIColor.yellowColor().CGColor;
        shapeLayer.backgroundColor = UIColor.redColor().CGColor;
/*2*/
        test2.addArcWithCenter(CGPointMake(0,0), radius: radius, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: false);
        
        let shapeLayer2 = CAShapeLayer();
        shapeLayer2.path = test2.CGPath;
        shapeLayer2.fillColor = UIColor.yellowColor().CGColor;
//        
        tempLayer = CALayer();
        tempLayer.addSublayer(shapeLayer);
        tempLayer.addSublayer(shapeLayer2);
        

        self.layer.mask = tempLayer;

/*1*/
        
        let animation1 = CAKeyframeAnimation();
        animation1.keyPath = "position";
        animation1.duration = seconds;
        animation1.delegate = self;
        animation1.values = [
            NSValue.init(CGPoint: CGPointMake(coverView.bounds.origin.x, coverView.bounds.origin.y)),
            NSValue.init(CGPoint: CGPointMake(coverView.bounds.size.width, coverView.bounds.origin.y)),
            NSValue.init(CGPoint: CGPointMake(coverView.bounds.size.width, coverView.bounds.size.height)),
            NSValue.init(CGPoint: coverView.center)
        ];
        let easeInEaseOut = CAMediaTimingFunction(name: "easeInEaseOut");

        animation1.timingFunctions = [easeInEaseOut,easeInEaseOut,easeInEaseOut,easeInEaseOut];
        animation1.keyTimes = [0.0,0.2,0.5,0.8,1.0];
        shapeLayer.position = coverView.center;
        
        
        
/*2*/
        let animation2 = CAKeyframeAnimation();
        animation2.keyPath = "position";
        animation2.duration = seconds;
        animation2.delegate = self;
        animation2.values = [
            NSValue.init(CGPoint: CGPointMake(coverView.bounds.size.width, coverView.bounds.size.height)),
            NSValue.init(CGPoint: CGPointMake(coverView.bounds.origin.x, coverView.bounds.size.height)),
            NSValue.init(CGPoint: CGPointMake(coverView.bounds.origin.x, coverView.bounds.origin.y)),
            
            NSValue.init(CGPoint: coverView.center)
        ];
        
        animation2.timingFunctions = [easeInEaseOut,easeInEaseOut,easeInEaseOut,easeInEaseOut];
        animation2.keyTimes = [0.0,0.2,0.5,0.8,1.0];
        shapeLayer2.position = coverView.center;
        
//      
        animation1.setValue(shapeLayer, forKey: "ani1");
        animation2.setValue(shapeLayer2, forKey: "ani2");
        
        shapeLayer.addAnimation(animation1, forKey: nil);
        shapeLayer2.addAnimation(animation2, forKey: nil);
        
    
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let animation = anim as! CAKeyframeAnimation;
        print("animation.key=\(animation.valueForKey("ani1"))");
        ((animation.valueForKey("ani1")) as? CAShapeLayer)?.setAffineTransform(CGAffineTransformMakeScale(self.bounds.size.width / radius / 2, self.bounds.size.height / radius / 2));
//        tempLayer.setAffineTransform(CGAffineTransformMakeScale(2, 2));
    }
    
    

}
