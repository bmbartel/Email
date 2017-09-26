//
//  DetailVC.swift
//  EmailExample
//
//  Created by Brandon on 9/26/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import Foundation

class DetailVC
{
    let detailVC: ViewController
    
    init (detailVC:ViewController)
    {
       self.detailVC = detailVC
    }
    func sendDetailVC() -> ViewController
    {
    return self.detailVC
    }

}
