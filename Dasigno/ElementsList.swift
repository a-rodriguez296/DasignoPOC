//
//  ElementsList.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/25/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import SwiftyJSON

class ElementsList: NSObject {
    
    let elements: [Element]
    
    init(json: JSON) {
        
        let tasksArray = json["Task"].array
        var auxArray = Array<Element>()
        
        for (subJson):(JSON) in tasksArray!{
            
            let element = Element(json: subJson)
            auxArray.append(element)
        
        }
        elements = auxArray
        
    }

}
