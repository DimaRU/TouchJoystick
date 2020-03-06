/////
////  ViewController.swift
///   Copyright © 2020 Dmitriy Borovikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var throttleJoystick: TouchJoystickView!
    @IBOutlet weak var yawJoystock: TouchJoystickView!
    @IBOutlet weak var horizontalJoystock: TouchJoystickView!

    private var savedCenter: [UIView: CGPoint] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let joystiks = [throttleJoystick, yawJoystock, horizontalJoystock]
        joystiks.forEach{ $0?.isHidden = false; $0?.delegate = self }
    }

    override func viewWillLayoutSubviews() {
        for view in view.subviews where view is DisabledLayout {
            savedCenter[view] = view.center
        }
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for (view, center) in savedCenter {
            view.center = center
        }
        savedCenter = [:]
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        throttleJoystick.frame.origin = CGPoint(x: 120, y: 80)
        yawJoystock.frame.origin = CGPoint(x: 400, y: 80)
        horizontalJoystock.frame.origin = CGPoint(x: 600, y: 20)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            guard touch.view == view || touch.view is TouchJoystickView else { continue }
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
    func joystickDidMove(_ joystickType: TouchJoystickView.JoystickType, to x: Float, y: Float) {
        print("\(joystickType.rawValue) joystick move to x:\(x) y:\(y)")
    }
    
    func joystickEndMoving(_ joystickType: TouchJoystickView.JoystickType) {
        print("\(joystickType.rawValue) joystick did end moving")
    }
}

