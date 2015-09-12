//
//  ViewController.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// extends the above class with functionality from another class.
extension NotesViewController:UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeueReusableCellWithIdentifier is a method of UITableView class that tries to find a reusable cell to improve initialization performance. When this cell scrolls off the screen, it will be added to an internal collection of cells that can be recycled; if none exists (as it will be the case when the app is first run), the method will create new instances of UITableViewCells, in this case, a custom subclass of UITableViewCell (NoteTableViewCell, located in the 'Views' directory) will be used.
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as! NoteTableViewCell //1;
        // the 'NoteCell' is an unique identifier for the NoteTableViewCell, allowing the use of many custom designs, each associated with its identifier. Every line printing 'Hello World' will be a 'NoteCell' NoteTableViewCell.
        
        let row = indexPath.row;
        cell.setTitle("Hello World");
        cell.setDate("10th", month: "October", year: "5776");
        
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5// number of rows to be returned. '5' is only an arbitrary test.
    }
}

