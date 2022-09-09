//
//  MaketodoViewController.swift
//  todo_day2
//
//  Created by Atsuhiro Muroyama on 2022/09/07.
//
import UIKit
import RealmSwift
class MaketodoViewController: UIViewController {
    let realm = try! Realm()
    var list: List<Todo>!
    //Todo型の配列(のようなもの)を宣言
    
    
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var shousaiTextField: UITextField!
    @IBOutlet weak var limitTextField: UITextField!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale(identifier: "MDY")
        limitTextField.inputView = datePicker
        //車輪型に指定している。
        datePicker.preferredDatePickerStyle = .wheels
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        limitTextField.inputView = datePicker
        limitTextField.inputAccessoryView = toolbar

    }
    @objc func done() {
        limitTextField.endEditing(true)
           
           // 日付のフォーマット
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy/MM/dd"
        limitTextField.text = "\(formatter.string(from: Date()))"
       }
    @IBAction func save(_ sender: Any) {
        let newTodo = Todo()
        newTodo.todo = todoTextField.text!
        newTodo.content = shousaiTextField.text!
        newTodo.date = limitTextField.text!
        
        do{
            let todolist = TodoList()
            todolist.list.append(newTodo)
            try realm.write{
                realm.add(todolist)
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
