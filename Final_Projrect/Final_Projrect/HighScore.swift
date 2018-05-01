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
    
    var theControl: GameControl? = nil
    
    //get the sidth and height of phone
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var highScores: Array<highScore> = Array()
    
    let main = UIButton(frame: CGRect(x: UIScreen.main.bounds.width
        - 100, y: 15, width: 100, height: 20))
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        //set the table
        scoreTable = UITableView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scoreTable.register(UITableViewCell.self, forCellReuseIdentifier: "ScoreCell")
        scoreTable.dataSource = self
        scoreTable.delegate = self
        
        addSubview(scoreTable)
        
        main.backgroundColor = .gray
        main.setTitleColor(.black, for: .normal)
        main.setTitle("Main Menu", for: .normal)
        main.addTarget(self, action: #selector(HighScore.toMain(sender:)), for: .touchUpInside)
        
        self.addSubview(main)

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
        if(highScores.count >= number)
        {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: highScores[indexPath.row].date as Date)
            let month = calendar.component(.month, from: highScores[indexPath.row].date as Date)
            let day = calendar.component(.day, from: highScores[indexPath.row].date as Date)

            cell.textLabel!.text = "\(number): Score: \(highScores[indexPath.row].score) Date: \(month)-\(day)-\(year)"
        }
        else{
            cell.textLabel!.text = "\(number):"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "HIGH SCORES"

    }
    
    @objc func toMain(sender: UIButton!) {
        theControl?.addMain()
        
    }
    
    func reload()
    {
        scoreTable.reloadData()
    }
    
    
}
