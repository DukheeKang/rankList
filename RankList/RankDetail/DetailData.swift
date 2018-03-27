//
//  DetailData.swift
//  RankList
//
//  Created by Dukhee Kang on 2018. 3. 27..
//  Copyright © 2018년 Dukhee Kang. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class ResultsObject: Object {

    @objc dynamic var trackViewUrl: String?
    @objc dynamic var trackName: String?
    @objc dynamic var releaseNotes: String?
    @objc dynamic var version: String?
    @objc dynamic var descriptions: String?
    @objc dynamic var sellerName: String?
    @objc dynamic var releaseDate: String?
    var screenshotUrls = List<String>()
    
    var dateString: String {
        return stringToDateTime(dateToStringTime(self.releaseDate!), dateFormat: "yyyyy년MM월dd일  HH시mm분ss초")
    }
    
}

class DetailObject: Object {
    @objc dynamic var resultCount: Int = 0
    var results = List<ResultsObject>()
}

class DetailData {
    
    var screenshotUrls = [String]()
    var firstDetail: ResultsObject?
    
    init(_ infoData:Data) {
        var dataString = String(data: infoData, encoding: .utf8)!
        dataString = dataString.replacingOccurrences(of: "description", with: "descriptions")
        let infoJson = JSON(parseJSON: dataString)
        
        let detail = DetailObject(value: infoJson.object)
        firstDetail = detail.results.first
        
    }

}
/*
Date문자열을 Date포멧형식에 맞게 Date로 리턴
@param Date문자열:String Date포멧 : Int
@returns Date : Date
@exception <#throws#>
*/
public func dateToStringTime(_ dateString:String = "", _ dateFormat:String = "yyyy-MM-dd'T'HH:mm:ss.sssZZZZZ") -> Date{
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = dateFormat
    let date = dateFormatter.date(from:dateString)
    return date ?? Date()
    
}

/**
 
 Date 값을 Date포멧형식에 맞게 문자열로 리턴
 @param nil
 @returns 현재 요일 : String
 @exception <#throws#>
 */
public func stringToDateTime(_ date:Date = Date(), dateFormat:String)->String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    let dateString = dateFormatter.string(from:date as Date)
    return dateString
}
