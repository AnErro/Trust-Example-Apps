//
//  calctrust.swift
//  TrustApp
//
//  Created by Dylan Ferguson on 2016-02-08.
//  Copyright © 2016 Dylan Ferguson. All rights reserved.
//

import Foundation


//TODO: Make this more robust once taught more about trust models
class turstmodel{
    var trust, importance, risk, utility: Float
    
    init(Trust trust: Float, Importance importance: Float, Risk risk: Float,Utility utility: Float ){
        self.trust = trust
        self.importance = importance
        self.risk = risk
        self.utility = utility
    }
    //TODO: Don't return out 0s
    var cooperation: Float{
        let coop = (risk / trust) * importance
        return Float(coop)
    }
    //TODO: Don't return out 0s
    var trustl: Float {
        let tlevel = utility * importance * trust
        return Float(tlevel)
    }

}


