//
//  Category .swift
//  Todoey
//
//  Created by Mohamed Samy on 8/8/20.
//  Copyright © 2020 Mohamed Samy. All rights reserved.
//

import Foundation
import RealmSwift


class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
