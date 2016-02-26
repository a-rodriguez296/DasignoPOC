//
//  Element.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/25/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import SwiftyJSON

class Element {

    let title:String
    let description:String
    let from:String
    let to:String
    
    
    init(json: JSON){
        title = json["Title"].stringValue
        description = json["Description"].stringValue
        from = json["From","Name"].stringValue
        to = json["To","Name"].stringValue
    }
    
}
