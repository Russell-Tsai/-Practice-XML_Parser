//
//  ViewController.swift
//  XML_Parser_MVC_04
//
//  Created by 蔡松樺 on 30/11/2017.
//  Copyright © 2017 蔡松樺. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var myParser = XMLParserModel()
    private var loadData = [RSSItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myParser.beginParer { (data) in
            loadData = data
            tableView.reloadData()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadData.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let infoDict = loadData[indexPath.row]
        cell.textLabel?.text = infoDict.Title
        cell.detailTextLabel?.text = infoDict.PubDate
        
        return cell
    }
    

}

