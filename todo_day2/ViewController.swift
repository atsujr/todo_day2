//
//  ViewController.swift
//  todo_day2
//
//  Created by Atsuhiro Muroyama on 2022/09/07.
//

import UIKit
import RealmSwift

class ViewController: UIViewController{
    
    var todolist: Results<Todo>!
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
            let realm = try Realm()
            todolist = realm.objects(Todo.self)
            //全件取得している
            tableview.reloadData()
        }catch{
            print("tableviewに移すときに失敗しました")
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TodoTableViewCell
        cell.todolabel.text = todolist[indexPath.row].todo
        cell.timelabel.text = todolist[indexPath.row].date
        return cell
    }
    
    
    
}

