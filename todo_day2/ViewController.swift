//
//  ViewController.swift
//  todo_day2
//
//  Created by Atsuhiro Muroyama on 2022/09/07.
//

import UIKit
import RealmSwift

class ViewController: UIViewController{
    
    var todolist: List<Todo>!
    let realm = try! Realm()
    @IBOutlet weak var tableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self
        
        
        
        do{
            todolist = realm.objects(TodoList.self).first?.list
            tableview.reloadData()
        }catch{
            print("tableviewに移すときに失敗しました")
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(TodoList.self).count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TodoTableViewCell
        cell.todolabel?.text = todolist[indexPath.row].todo
        cell.timelabel?.text = todolist[indexPath.row].date
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                let item = todolist[indexPath.row]
                realm.delete(item)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        try! realm.write {
            let listItem = todolist[fromIndexPath.row]
            todolist.remove(at: fromIndexPath.row)
            todolist.insert(listItem, at: to.row)
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}
extension List {
    subscript (save index: Int) -> Element? {
        if index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
}

