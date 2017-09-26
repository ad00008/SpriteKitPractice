//
//  GameViewController.swift
//  RestaurantManager
//
//  Created by 胡杨林 on 2017/9/19.
//  Copyright © 2017年 胡杨林. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MainScene(size: self.view!.frame.size)
                scene.scaleMode = .aspectFill
                view.presentScene(scene)

//            let tech = TechViews(frame: CGRect.zero)
//            view.addSubview(tech)
            view.backgroundColor = UIColor.white

            let model = EmployeeModel.init()
            let employee = employeeViewInMarket.BuildEmployeeView(model: model, PositionPoint: CGPoint(x: 50, y: 50))
            view.addSubview(employee)
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.ignoresSiblingOrder = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .landscape
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
