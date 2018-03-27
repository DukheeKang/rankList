//
//  RankDetailVC.swift
//  RankList
//
//  Created by Dukhee Kang on 2018. 3. 27..
//  Copyright © 2018년 Dukhee Kang. All rights reserved.
//

import UIKit

struct InfoType {
    var key:String
    var value:String
}

class RankDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var ids:String = ""

    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var detailTable: UITableView!
    
    private var detailData = ResultsObject()
    private var model = APIModel.init()
    private var indicator = IndicatorView.init()
    
    private var detailKeys = [InfoType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.activityIndicator(view: self.view)
        indicator.startIndicator()
        
        model = APIModel.init(getType: true,
                              callString: APIList.DETAIL_API.replacingOccurrences(of: APIList.RANK_ID_MARK, with: ids))
        model.requestGetStringURL(
            updateData : { res in
                self.dataParsing(res)
        },
            errorData : { error in
                Swift.debugPrint(error.localizedDescription)
        }
        )
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Data Parsing
    func dataParsing(_ res:Data) {
        let resData = DetailData.init(res)
        let firstDetail = resData.firstDetail
        detailKeys = [InfoType(key:"앱 이름",value:firstDetail!.trackName ?? ""),
                      InfoType(key: "앱 설명", value: firstDetail!.descriptions ?? ""),
                      InfoType(key: "앱 버전", value: firstDetail!.version ?? ""),
                      InfoType(key: "앱 업데이트 일시", value: firstDetail!.dateString),
                      InfoType(key: "앱 업데이트 내용", value: firstDetail!.releaseNotes ?? ""),
                      InfoType(key: "앱 판매자", value: firstDetail!.sellerName ?? "")]
        
        model.downloadImageURL(
            imageURL: firstDetail?.screenshotUrls.first ?? "",
            downloadFinish: { imageData in
                DispatchQueue.main.async {
                    self.appImage?.image = UIImage.init(data: imageData)
                    self.appImage?.setNeedsLayout()
                }
        },
            errorData : { error in
                Swift.debugPrint(error.localizedDescription)
        }
        )
        
        DispatchQueue.main.async {
            self.detailTable.reloadData()
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
        return detailKeys.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellInfo = detailKeys[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailCell
        
        cell.keyTitle.text = cellInfo.key
        cell.valueString.text = cellInfo.value
        return cell
        
    }

}
