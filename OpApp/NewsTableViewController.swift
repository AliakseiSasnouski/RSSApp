//
//  NewsTableViewController.swift
//  OpApp
//
//  Created by MacBook on 08.07.17.
//  Copyright © 2017 MacBook. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import AlamofireImage

class NewsTableViewController: UITableViewController {
    
    var siteModel: SiteModel?
    var newsArray: [NewsModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = siteModel?.url {
            let request = Alamofire.request(url)
            request.responseData(completionHandler: { [weak self] (response) in
                if let data = response.data {
                    let xml = SWXMLHash.parse(data)
                    
                    let items = xml["rss"]["channel"]["item"].all
                    var newsArray = [NewsModel]()
                    
                    items.forEach({ (item) in
                        newsArray.append(NewsModel(title: item["title"].element?.text, subTitle: item["link"].element?.text, imageURL: URL(string: (item["media:content"].element?.attribute(by: "url")?.text ?? ""))))
                        
                    })
                    self?.newsArray = newsArray
                    self?.tableView.reloadData()
                }
            })
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let length = newsArray?.count ?? 0
        return length > 10 ? 10 : length
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsID", for: indexPath) as? NewsTableViewCell {
            let newsModel = newsArray?[indexPath.row]
            if let url = newsModel?.imageURL {
                cell.imageNewsView.af_setImage(withURL: url)
            }
            cell.titleLabel.text = newsModel?.title
            cell.subtitleView.text = newsModel?.subTitle
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
