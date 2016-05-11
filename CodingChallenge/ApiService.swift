//
//  ApiService.swift
//  CodingChallenge
//
//  Created by jason debottis on 5/9/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import Foundation
import Alamofire

@objc class ApiService: NSObject , NSURLSessionDelegate, NSURLSessionTaskDelegate{
    
    
    @objc static func GetServiceProviders( completion:(result:AnyObject, finished: Bool) -> Void){
        Alamofire.request(.GET,Constants.BaseUrl).responseJSON { response in
            completion(result: response.result.value!, finished: true)
        }
            
    }
}