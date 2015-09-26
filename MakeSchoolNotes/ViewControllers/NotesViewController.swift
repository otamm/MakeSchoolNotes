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
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            
            let realm = Realm();
            
            switch identifier {
            // in case the "save" button was pressed at the last view controller, saves the note.
            case "Save":
                // accesses the past NewNoteViewController;
                let source = segue.sourceViewController as! NewNoteViewController; //1
                
                realm.write() {
                    // stores the 'note' attribute of the past NewNoteViewController;
                    realm.add(source.note!);
                }
            // else, doesn't do anything.
            default:
                println("No one loves \(identifier)");
            }
            
            self.notes = realm.objects(Note).sorted("modificationDate", ascending: false);
        
        }
    }
    
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
        // adds extension NotesViewController:UITableViewDataSource (located below) as delegate
        self.tableView.delegate = self;
        
        // dynamically adds an arbitrary note to test table view reloading and displaying new info gotten after some note addition:
        let myNote = Note();
        myNote.title = "Some useless testing text";
        myNote.content = "raw static information is worth nothing.";
        
        // establishes a connection to Realm.
        //do {
            let realm = Realm();
        //} catch {
        //    println("handling error");
        //}
        // write method will store information that can be afterwards retrieved; this storage logic will be provided via a closure.
        //realm.write() {
        //    realm.deleteAll(); // clears the app out of data.
        //    realm.add(myNote);
        //}
        
        // fetches saved notes and assigns the fetch value to the 'notes' variable:
        //self.notes = realm.objects(Note);
        // sorts notes' display based on the 'modificationDate' row in descending order.
        self.notes = realm.objects(Note).sorted("modificationDate", ascending: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// extends the above class with functionality from another class.

// implements basic logic of data source.
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

// implements further functionalities with Realm, allowing access to a specific data cell displayed.
extension NotesViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //1 When a note has been selected, we want to assign this note to a variable for easy access. When a row is selected, the row index is passed as a parameter so we can grab the correct note object using the objectAtIndex method.
        
        //currentNote = notes[indexPath.row]
        
        //2
        // We will be performing a segue to a new Note Display View Controller that will display the selected note.
        
        //self.performSegueWithIdentifier("ShowExistingNote", sender: self)
    }
    
    // 3 This function is used to check if a row can be edited. In our app we would always like this behaviour, so it will always return true.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // 4 This function is activated when you left swipe your Table View to enter edit mode and are presented with the option to Delete the selected row.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let note = self.notes[indexPath.row] as Object;
            
            let realm = Realm();
            
            realm.write() {
                realm.delete(note);
            }
            
            self.notes = realm.objects(Note).sorted("modificationDate", ascending: false);
        }
    }
    
}

