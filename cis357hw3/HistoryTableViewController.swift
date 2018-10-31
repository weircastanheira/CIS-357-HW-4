//
//  HistoryTableViewController.swift
//  cis357hw3
//
//  Created by Workbook on 10/31/18.
//  Copyright © 2018 Workbook. All rights reserved.
//

import UIKit

protocol HistoryTableViewControllerDelegate {
    func selectEntry(entry: Conversion)
}

class HistoryTableViewController: UITableViewController {
    var entries : [Conversion] = []

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // your code goes here
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // your code goes here
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        // your code goes here.
        
        return cell
    }
}
