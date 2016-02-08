//
//  ViewController.swift
//  TrustApp
//
//  Created by Dylan Ferguson on 2016-02-07.
//  Copyright © 2016 Dylan Ferguson. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
   
    var  session  :  WCSession!
    
    required init(coder aDecoder: NSCoder) {
        self.session = WCSession.defaultSession()
        super.init(coder: aDecoder)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (WCSession.isSupported()) {
            session.delegate = self
            session.activateSession()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Attributes
    @IBOutlet weak var tslide: UISlider!
    @IBOutlet weak var rslide: UISlider!
    @IBOutlet weak var islide: UISlider!
    @IBOutlet weak var uslide: UISlider!
    @IBOutlet weak var tvalue: UILabel!
    @IBOutlet weak var rvalue: UILabel!
    @IBOutlet weak var ivalue: UILabel!
    @IBOutlet weak var uvalue: UILabel!
    @IBOutlet weak var coopView: UILabel!
    @IBOutlet weak var tlevelView: UILabel!
    
    
    
    
    //MARK: Actions
    
    @IBAction func t_update(sender: AnyObject) {
        tvalue.text = String(format: "Value  %.2f",tslide.value)
    }
    @IBAction func r_update(sender: AnyObject) {
        rvalue.text = String(format: "Value  %.2f",rslide.value)
    }
    @IBAction func i_update(sender: AnyObject) {
        ivalue.text = String(format: "Value  %.2f",islide.value)
    }
    @IBAction func u_update(sender: AnyObject) {
        uvalue.text = String(format: "Value  %.2f",uslide.value)
    }
    
    @IBAction func calc(sender: AnyObject) {
        
        let current = turstmodel(Trust: tslide.value, Importance: islide.value, Risk: rslide.value, Utility: uslide.value)
        coopView.text = String(format: "Cooperation Threshhold: %.2f", current.cooperation)
        tlevelView.text = String(format: "Trust Level: %.2f", current.trustl)
        
        guard let settings = UIApplication.sharedApplication().currentUserNotificationSettings() else { return }
        
        if settings.types == .None {
            let ac = UIAlertController(title: "Can't Do It :(", message: "We don't have permisions to do this notification business", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            return
        }
        
        let notification = UILocalNotification()
        /*MARK: Notification Settings:
        fireDate: is the delay
        alertAction: is the small text underneith the notification
        userInfo:
        */
        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.alertBody = String(format: "Cooperation Threshhold: %.2f , Trust Level: %.2f", current.cooperation, current.trustl)
        notification.alertAction = "I know"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "It worked!"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        if(WCSession.isSupported()){
            let message = ["coop": current.cooperation, "trust": current.trustl];
            
            //send message dictionary
            session.sendMessage(message, replyHandler: { (content:[String : AnyObject]) -> Void in
                print("Our counterpart sent something back. This is optional")
                }, errorHandler: {  (error ) -> Void in
                    print("We got an error from our paired device : " + error.domain)
            })
        }
    }
    
    @IBAction func regLocalNoticifications(sender: AnyObject) {
        let nset = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(nset)
    }
    
   

}


