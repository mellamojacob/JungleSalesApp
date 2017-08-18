//
//  Tier.swift
//  Jungle Sales
//
//  Created by Jacob Virgin on 8/10/16.
//  Copyright © 2016 Jacob Virgin. All rights reserved.
//

import UIKit
import Foundation

class Tier {
    enum TierDescription: String {
        case New
        case Voice2Voice
        case Face2Face
        case Proposal
        case Contract
    }
    
    var tierName: TierDescription
    
    init() {
        self.tierName = TierDescription.Voice2Voice
        
    }
    
    init(tier: String) {
        self.tierName = Tier.convertToTier(tier)
        
    }
    
    class func moveUpTier(_ tier: TierDescription) -> Tier.TierDescription {
        switch tier {
        case TierDescription.Voice2Voice: return TierDescription.Face2Face
        case TierDescription.Face2Face: return TierDescription.Proposal
        case TierDescription.Proposal: return TierDescription.Contract
        default: return TierDescription.Voice2Voice
            
        }
    }
    
    class func convertToTier(_ tier: String) -> Tier.TierDescription{
        switch tier {
        case "Voice2Voice" : return Tier.TierDescription.Voice2Voice
        case "Face2Face": return Tier.TierDescription.Face2Face
        case "Proposal": return Tier.TierDescription.Proposal
        case "Contract": return Tier.TierDescription.Contract
        default: return Tier.TierDescription.Voice2Voice
        }
    }
    
    
}
