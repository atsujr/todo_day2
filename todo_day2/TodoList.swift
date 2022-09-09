//
//  TodoList.swift
//  todo_day2
//
//  Created by Atsuhiro Muroyama on 2022/09/09.

import UIKit
import RealmSwift

class TodoList: Object {
    let list = List<Todo>()
}
