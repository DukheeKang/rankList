//
//  RankListVC.swift
//  RankList
//
//  Created by Dukhee Kang on 2018. 3. 27..
//  Copyright © 2018년 Dukhee Kang. All rights reserved.
//

import UIKit
import SwiftyJSON

//https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json
//https://itunes.apple.com/lookup?id={id}&country=kr

class RankListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var rankTable: UITableView!
    
    private var rankDataArr = [EntryObject]()
    private var model = APIModel.init()
    private var indicator = IndicatorView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "랭크"
        
        indicator.activityIndicator(view: self.view)
        indicator.startIndicator()
        model = APIModel.init(getType: true,
                              callString: APIList.RANK_API.replacingOccurrences(of: APIList.RANK_CNT_MARK, with: APIList.RANK_CNT))
        model.requestGetStringURL(
            updateData : { res in
                self.dataParsing(res)
            },
            errorData : { error in
                Swift.debugPrint(error.localizedDescription)
            }
        )
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: - Data Parsing
    func dataParsing(_ res:Data) {
        let rankData = RankData.init(res)
        rankDataArr = (rankData.feed?.entry.map { $0 })!
        
        DispatchQueue.main.async {
            self.rankTable.reloadData()
            self.indicator.stopIndicatior()
        }
        
    }
    
    // MARK: - TableView Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankDataArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellInfo = rankDataArr[indexPath.row]
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "rankCell")
        
        cell.textLabel?.text = cellInfo.title?.label ?? ""
        
        let imageURLString = cellInfo.im_image.first?.label ?? ""
        cell.imageView?.image = #imageLiteral(resourceName: "imageBackGround")
        model.downloadImageURL(
            imageURL: imageURLString,
            downloadFinish: { imageData in
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage.init(data: imageData)
                    cell.setNeedsLayout()
                }
            },
            errorData : { error in
                Swift.debugPrint(error.localizedDescription)
            }
        )
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellInfo = rankDataArr[indexPath.row]
        let ids = cellInfo.id?.attributes?.im_id ?? ""
        guard ids.count > 0 else {
            return
        }
        let rankDetailVC = UIStoryboard(name: "RankDetail", bundle: nil).instantiateViewController(withIdentifier: "RankDetailVC") as! RankDetailVC
        rankDetailVC.title = cellInfo.im_name?.label ?? ""
        rankDetailVC.ids = ids
        navigationController?.pushViewController(rankDetailVC, animated:true)
    }

}

