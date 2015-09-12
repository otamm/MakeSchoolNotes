//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import Foundation;
import RealmSwift;

class Note : Object {
    
    dynamic var title:String = ""; // dynamic here indicates to the compiler that this property will be set at runtime.
    
    dynamic var content:String = "";
    
    dynamic var modificationDate = NSDate();
    
}