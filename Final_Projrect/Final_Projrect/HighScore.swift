//
//  HighScore.swift
//  Final_Projrect
//
//  Created by Stephen Reese on 4/5/18.
//  Copyright © 2018 Stephen Reese. All rights reserved.
//

import UIKit

class HighScore: UIView, UITableViewDelegate, UITableViewDataSource
{
    var scoreTable : UITableView!
    
    //get the sidth and height of phone
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        //set the table
        scoreTable = UITableView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scoreTable.register(UITableViewCell.self, forCellReuseIdentifier: "ScoreCell")
        scoreTable.dataSource = self
        scoreTable.delegate = self
        
        addSubview(scoreTable)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath as IndexPath)
        var number = indexPath.row + 1;
        cell.textLabel!.text = "\(number):"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "HIGH SCORES"

    }
    
    
}
