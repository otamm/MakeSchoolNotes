//
//  NewNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Otavio Monteagudo on 9/12/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    var note:Note?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.note = Note();
        self.note!.title = "TITLE TITLE";
        self.note!.content = "CONTENT CONTENT";
    }
    

}
