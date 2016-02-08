//
//  calctrust.swift
//  TrustApp
//
//  Created by Dylan Ferguson on 2016-02-08.
//  Copyright © 2016 Dylan Ferguson. All rights reserved.
//

import Foundation



class turstmodel{
    var trust, importance, risk, utility: Float
    
    init(Trust trust: Float, Importance importance: Float, Risk risk: Float,Utility utility: Float ){
        self.trust = trust
        self.importance = importance
        self.risk = risk
        self.utility = utility
    }

    var cooperation: Float{
        let coop = (risk / trust) * importance
        return Float(coop)
    }
    
    var trustl: Float {
        let tlevel = utility * importance * trust
        return Float(tlevel)
    }
   /*
    let tlevel = utility_slider.value * import_slider.value * trust_slider.value
    let coop = (risk_slider.value / trust_slider.value) * import_slider.value
    */
}


