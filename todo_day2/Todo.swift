//
//  Todo.swift
//  todo_day2
//
//  Created by Atsuhiro Muroyama on 2022/09/07.
//

import Foundation
import RealmSwift

class Todo: Object {
    @objc dynamic var todo: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var date: String = ""
    
}
