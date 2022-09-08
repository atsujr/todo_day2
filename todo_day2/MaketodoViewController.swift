//
//  MaketodoViewController.swift
//  todo_day2
//
//  Created by Atsuhiro Muroyama on 2022/09/07.
//
import UIKit
import RealmSwift
class MaketodoViewController: UIViewController {
    //realmを宣言
    //var list: List<Todo>!
    //Todo型の配列(のようなもの)を宣言
    
    
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var shousaiTextField: UITextField!
    @IBOutlet weak var limitTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    @IBAction func save(_ sender: Any) {
        let newTodo = Todo()
        newTodo.todo = todoTextField.text!
        newTodo.content = shousaiTextField.text!
        newTodo.date = limitTextField.text!
        
        do{
            let realm = try Realm()
            try realm.write{
                realm.add(newTodo)
                print("ToDo Saved")
            }
        }catch{
            print("Save is Faild")
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
