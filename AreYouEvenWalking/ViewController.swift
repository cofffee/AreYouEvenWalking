//
//  ViewController.swift
//  AreYouEvenWalking
//
//  Created by Kevin Remigio on 7/20/17.
//  Copyright © 2017 Kevin Remigio. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox

class ViewController: UIViewController {
    
    var activity: CMMotionActivity? = nil
    var actManager: CMMotionActivityManager? = nil
    var activityState:UILabel? = nil
    var actString:String = ""{
        didSet {
            activityState?.text = actString
            if actString == "WALKING" {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                activityState?.textColor = UIColor.red
            } else {
                activityState?.textColor = UIColor.black
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actManager = CMMotionActivityManager()
        activity = CMMotionActivity()
        let actFrame = CGRect(x: 0, y: (view.frame.height / 2) - 75, width: view.frame.width, height: 150)
        activityState = UILabel(frame: actFrame)
        activityState?.textAlignment = .center
        activityState?.font = UIFont(name: "Helvetica", size: 75)
        activityState?.lineBreakMode = .byClipping
        view.addSubview(activityState!)
        
        if(CMMotionActivityManager.isActivityAvailable()){
            print("YES!")
            self.actManager?.startActivityUpdates(to: OperationQueue.main) { data in
                if let data = data {
                    DispatchQueue.main.async() {
                        if(data.stationary == true){
                            self.actString = "STANDING"
                            print("Stationary")
                        } else if (data.walking == true){
                            self.actString = "WALKING"
                            print("Walking")
                        } else if (data.running == true){
                            self.actString = "RUNNING"
                            print("Running")
                        } else if (data.automotive == true){
                            self.actString = "RIDING"
                            print("Driving")
                        }
                    }
                }
            }
        }

    }




}

