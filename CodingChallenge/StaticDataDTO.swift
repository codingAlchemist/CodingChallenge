//
//  StaticDataDTO.swift
//  CodingChallenge
//
//  Created by jason debottis on 5/9/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit
import SwiftyJSON

@objc class StaticDataDTO: NSObject {
    let apiService = ApiService()
    var providers = NSMutableDictionary()
    class var swiftSharedInstance: StaticDataDTO {
        struct Static {
            static let instance = StaticDataDTO()
        }
        return Static.instance
    }
    
    class func sharedInstance() -> StaticDataDTO {
        return StaticDataDTO.swiftSharedInstance;
    }
    
    func getProviders( completion:(data: NSMutableDictionary, finished: Bool)->Void) ->Void{
        ApiService.GetServiceProviders { (result, finished) in
            print(result)
            completion(data: result as! NSMutableDictionary, finished: finished)
        }
        
    }
}
