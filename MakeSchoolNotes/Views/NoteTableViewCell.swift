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
