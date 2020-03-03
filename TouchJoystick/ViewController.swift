/////
////  ViewController.swift
///   Copyright © 2020 Dmitriy Borovikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var throttleJoystick: TouchJoystickView!
    @IBOutlet weak var yawJoystock: TouchJoystickView!
    @IBOutlet weak var horizontalJoystock: TouchJoystickView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let joystiks = [throttleJoystick, yawJoystock, horizontalJoystock]
        joystiks.forEach{ $0?.isHidden = true; $0?.delegate = self }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: view)
            if location.y < view.bounds.midY {
                horizontalJoystock.touchBegan(touch: touch)
            } else if location.x < view.bounds.midX {
                throttleJoystick.touchBegan(touch: touch)
            } else {
                yawJoystock.touchBegan(touch: touch)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            throttleJoystick.touchMoved(touch: touch)
            yawJoystock.touchMoved(touch: touch)
            horizontalJoystock.touchMoved(touch: touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            throttleJoystick.touchEnded(touch: touch)
            yawJoystock.touchEnded(touch: touch)
            horizontalJoystock.touchEnded(touch: touch)
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            throttleJoystick.touchEnded(touch: touch)
            yawJoystock.touchEnded(touch: touch)
            horizontalJoystock.touchEnded(touch: touch)
        }
    }
}

extension ViewController: TouchJoystickViewDelegate {
    func joystickDidMove(_ joystickView: TouchJoystickView, to x: Float, y: Float) {
        let joystickName: String
        switch joystickView {
        case throttleJoystick: joystickName = "throttle"
        case yawJoystock: joystickName = "yaw"
        case horizontalJoystock: joystickName = "horizontal"
        default: fatalError()
        }
        
        print("\(joystickName) joystick move to x:\(x) y:\(y)")
    }
    
    func joystickEndMoving(_ joystickView: TouchJoystickView) {
        let joystickName: String
        switch joystickView {
        case throttleJoystick: joystickName = "throttle"
        case yawJoystock: joystickName = "yaw"
        case horizontalJoystock: joystickName = "horizontal"
        default: fatalError()
        }
        print("\(joystickName) joystick did end moving")
    }
}
