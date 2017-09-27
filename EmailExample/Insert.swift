//
//  Insert.swift
//  EmailExample
//
//  Created by Brandon on 9/26/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import Foundation

// This can pull the array of strings for the selected email from rootTVC, I think. Now I need to get this over to AppDelegate and throw it into the DataDictionary.

class Insert
{
    let selectedEmail: [String : Array<Email>]
    
    init(selectedEmail: [String : Array<Email>])
    {
        self.selectedEmail = selectedEmail
    }
    
}
