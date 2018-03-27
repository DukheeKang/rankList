//
//  APIModel.swift
//  RankList
//
//  Created by Dukhee Kang on 2018. 3. 27..
//  Copyright © 2018년 Dukhee Kang. All rights reserved.
//

import UIKit


class APIModel {
    
    private var type: String = "GET"
    private var urlString: String = ""
    
    init(getType:Bool = true , callString:String = ""){
        type = getType ?  "GET" : "POST"
        urlString = callString
    }
    
    func requestGetStringURL(updateData:@escaping ((Data)->Void),  errorData: ((Error) -> Void)? = nil) {
        let urltoString = URL(string: urlString)!
        var requestURL = URLRequest(url: urltoString, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        requestURL.httpMethod = "GET"
    
        URLSession.shared.dataTask(with: requestURL, completionHandler: { (data, response, error) -> Void in
            guard error == nil else {
                errorData?(error!)
                return
            }
            updateData(data!)
        }).resume()
    }
    
    func downloadImageURL(imageURL:String = "", downloadFinish:@escaping ((Data)->Void),  errorData: ((Error) -> Void)? = nil) {
        
        let urltoString = URL(string: imageURL)!
        URLSession.shared.dataTask(with: urltoString, completionHandler: { (data, response, error) in
            
            guard error == nil else {
                errorData?(error!)
                return
            }
            downloadFinish(data!)
        }).resume()
        
    }
}

