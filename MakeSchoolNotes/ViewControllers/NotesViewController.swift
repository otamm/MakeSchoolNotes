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
    
    var notes: Results<Note>! {
        didSet {
            // Whenever notes update, update the table view
            self.tableView?.reloadData();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self;
        
        // dynamically adds an arbitrary note to test table view reloading and displaying new info gotten after some note addition:
        let myNote = Note();
        myNote.title = "Some useless testing text";
        myNote.content = "raw static information is worth nothing.";
        
        // establishes a connection to Realm.
        let realm = Realm();
        // write method will store information that can be afterwards retrieved; this storage logic will be provided via a closure.
        realm.write() {
            realm.add(myNote);
        }
        
        // fetches saved notes and assigns the fetch value to the 'notes' variable:
        self.notes = realm.objects(Note);
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
        //cell.setTitle("Hello World");
        //cell.setDate("10th", month: "October", year: "5776");
        let note = self.notes[row] as Note; // fetches the specific note for that row and loads it as a Note instance.
        cell.note = note; // assigns this note instance to the 'note' property of cell and returns this cell with the 'note' property assigned.
        
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 5// number of rows to be returned. '5' is only an arbitrary test.
        // returns the number of notes currently stored (if the total size of 'notes' is bigger than 0, returns the number of items stored in the 'notes' property. Otherwise, return 0):
        return Int(self.notes?.count ?? 0);
        /* equivalent to
        if let notes = notes {
            return Int(notes.count);
        } else {
            return 0;
        }*/
    }
}

