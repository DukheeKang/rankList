//
//  RankData.swift
//  RankList
//
//  Created by Dukhee Kang on 2018. 3. 27..
//  Copyright © 2018년 Dukhee Kang. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class AttrObject: Object {
//    @objc dynamic var term: String?
    @objc dynamic var label: String?
//    @objc dynamic var amount: String?
//    @objc dynamic var currency: String?
    @objc dynamic var im_id: String?
    @objc dynamic var im_bundleId : String?
}
class LabelObject: Object{
    @objc dynamic var label: String?
    @objc dynamic var attributes: AttrObject?
}

class EntryObject: Object{
    @objc dynamic var title: LabelObject?
    @objc dynamic var id: LabelObject?
    @objc dynamic var im_name: LabelObject?
    var im_image = List<LabelObject>()
    
}
class AuthorObject: Object {
    @objc dynamic var name: LabelObject?
    @objc dynamic var uri: LabelObject?
}
class FeedObject: Object {
    
//    @objc dynamic var author: AuthorObject?
    var entry = List<EntryObject>()
//    @objc dynamic var updated: LabelObject?
    @objc dynamic var title: LabelObject?
//    @objc dynamic var icon: LabelObject?
}

class RankData {
    
    var feed: FeedObject?
    init(_ infoData:Data) {
        var dataString = String(data: infoData, encoding: .utf8)!
        dataString = dataString.replacingOccurrences(of: "im:", with: "im_")
        let infoJson = JSON(parseJSON: dataString)
        
        feed = FeedObject(value: infoJson["feed"].object)
    }
}
