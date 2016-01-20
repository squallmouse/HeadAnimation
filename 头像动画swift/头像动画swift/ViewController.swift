//
//  ViewController.swift
//  头像动画swift
//
//  Created by 袁昊 on 16/1/14.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.yellowColor();
        let head = HeadAnimationView(frame: CGRectMake(100, 100, 250, 250), andImage: UIImage(named: "5.jpg")!);
        self.view.addSubview(head);
        
        head.headAnimationBegin(4);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

