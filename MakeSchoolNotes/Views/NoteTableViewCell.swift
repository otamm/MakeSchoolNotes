//
//  NoteTableViewCell.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class NoteTableViewCell: UITableViewCell {
    
    
    // initialize the date formatter only once, using a static computed property;
    // since this code will be the same used for all date table rows, it is worthy to initialize it only once.
    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter();
        formatter.dateFormat = "yyyy-MM-dd";
        return formatter;
    } ();
    
    var note: Note? {
        // called whenever this note variable is modified. For example, if the note gets edited, this will be called and update the title or date label in the corresponding note cell.
        didSet {
            // sets this cell's titleLabel, dateLabel and note to these constants; if the note, the titleLabel aaand dateLabel variables are set, execute the code block below.
            if let note = self.note, titleLabel = self.titleLabel, dateLabel = self.dateLabel {
                // sets the note's data cell title label to the same value as the title associated with the note instance.
                //self.titleLabel.text = note.title; 
                self.setTitle(self.note!.title);
                // same, with the date label.
                self.dateLabel.text = NoteTableViewCell.dateFormatter.stringFromDate(note.modificationDate);
            }
        }
    }
    
    // title of the cell.
    @IBOutlet weak var titleLabel:UILabel!;
    // last modification of the cell.
    @IBOutlet weak var dateLabel:UILabel!;
    
    func setDate(day: String, month: String, year: String) {
        
        self.dateLabel.text = month + " " + day + ", " + year;
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title;
    }
    
}
