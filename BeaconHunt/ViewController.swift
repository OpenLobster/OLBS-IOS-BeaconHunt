//
//  ViewController.swift
//  BeaconHunt
//
//  Created by Edward Yau on 22/7/15.
//  Copyright (c) 2015 OpenLobster. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //obtain the location manager instance in AppDelegate
        (UIApplication.sharedApplication().delegate as! AppDelegate).locationManager.delegate = self
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!)
    {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0)
        {
            let closestBeacon = knownBeacons[0] as! CLBeacon
            
            if(OLBSAPI.sharedInstance.beaconChanged(closestBeacon))
            {
                //perform OLBS Estimate Location
                let result = OLBSAPI.sharedInstance.estimateOLBSLocation(closestBeacon)
                
                //perform sendMSG2UserAtLocationWithWebCallBack
                if(OLBSAPI.sharedInstance.OLBSLocation.LUUID != "")
                {
                    let numberOfUsers = OLBSAPI.sharedInstance.sendMSG2UserAtLocationWithWebCallBack(OLBSAPI.sharedInstance.OLBSLocation.LUUID, MSG:"Hello!")
                    NSLog("didRangeBeacons: Number of Users Sent \(numberOfUsers)")
                }
            }
        }
    }
    
    
//    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!)
//    {
//            NSLog("You entered the region")
//    }
//    
//    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!)
//    {
//            NSLog("You exited the region")
//    }
    

}

