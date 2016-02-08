//
//  InterfaceController.swift
//  watch Extension
//
//  Created by Dylan Ferguson on 2016-02-08.
//  Copyright © 2016 Dylan Ferguson. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    //MARK: Attributes
    var  session  :  WCSession!
    @IBOutlet var tlabel: WKInterfaceLabel!
    @IBOutlet var clabel: WKInterfaceLabel!
    
    override init() {
        if(WCSession.isSupported()) {
            session =  WCSession.defaultSession()
        } else {
            session = nil
        }
    }
    
    //MARK: Actions
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }
  
    
    override func willActivate() {
        super.willActivate()
        //Set self to delegate messages
        if(WCSession.isSupported()) {
            session.delegate = self
            session.activateSession()
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // So this is pretty straight forward but only handels these 2 responces from message dictionary
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        print("We got this from phone:" + message.description)
        
        if let cvalue = message["coop"] as! Float?{
            clabel.setText(String(format: "Coop: %.2f", cvalue))
        }
        if let tvalue = message["trust"] as! Float?{
            tlabel.setText(String(format: "Trust Level: %.2f", tvalue))
        }
        
    }
}
