//
//  File.swift
//  Todoey
//
//  Created by Tee Yong Lim on 5/26/18.
//  Copyright © 2018 Tee Yong Lim. All rights reserved.
//

import Foundation

class Item: Decodable, Encodable{
    var title: String = ""
    var done: Bool = false
    
}
