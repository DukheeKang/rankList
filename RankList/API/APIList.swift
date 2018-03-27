//
//  APIList.swift
//  RankList
//
//  Created by Dukhee Kang on 2018. 3. 27..
//  Copyright © 2018년 Dukhee Kang. All rights reserved.
//

import UIKit

class APIList {
    static let RANK_CNT = "50"
    static let RANK_CNT_MARK = "{CNT}"
    static let RANK_ID_MARK = "{ID}"
    
    static let RANK_API = "https://itunes.apple.com/kr/rss/topfreeapplications/limit={CNT}/genre=6015/json"
    static let DETAIL_API = "https://itunes.apple.com/lookup?id={ID}&country=kr"
}
