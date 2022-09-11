//
//  ViewController.swift
//  todo_day2
//
//  Created by Atsuhiro Muroyama on 2022/09/07.
//

import UIKit
import RealmSwift

class ViewController: UIViewController{
    var todos = [Todo]()
    //var todolist: List<Todo>!
    
    var nextnum: Int!
    let realm = try! Realm()
    @IBOutlet weak var tableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
        //todolist = realm.objects(TodoList.self).first?.list
        todos = Array(realm.objects(Todo.self))
        
        //配列が全部帰ってくる(realmに入ってるtodo型のやつが全部帰ってくる)
        tableview.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    @IBAction func narabilae(_ sender: Any) {
        if(tableview.isEditing){
        tableview.isEditing = false
        }else{
            tableview.isEditing = true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNextViewController" {
            let nextVC = segue.destination as! EditViewController
            nextVC.selectedrowNum = nextnum
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Todo.self).count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TodoTableViewCell
        cell.todolabel?.text = todos[indexPath.row].todo
        cell.timelabel?.text = todos[indexPath.row].date
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                let item = todos[indexPath.row]
                todos.remove(at: indexPath.row)
                realm.delete(item)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        try! realm.write {
            let listItem = todos[fromIndexPath.row]
            todos.remove(at: fromIndexPath.row)
            todos.insert(listItem, at: to.row)
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        nextnum = indexPath.row
        // 別の画面に遷移
        performSegue(withIdentifier: "toNextViewController", sender: nil)
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

