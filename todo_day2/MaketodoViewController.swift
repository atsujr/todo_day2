//
//  MaketodoViewController.swift
//  todo_day2
//
//  Created by Atsuhiro Muroyama on 2022/09/07.
//
import UIKit
import RealmSwift
class MaketodoViewController: UIViewController, UITextFieldDelegate {
    let realm = try! Realm()
    //    var list: List<Todo>!
    //Todo型の配列(のようなもの)を宣言
    
    
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var shousaiTextField: UITextField!
    @IBOutlet weak var limitTextField: UITextField!
    
    //var datePicker: UIDatePicker = UIDatePicker()
    var toolBar:UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        limitTextField.delegate = self
        setupToolbar()
        
    }
    func setupToolbar() {
        //datepicker上のtoolbarのdoneボタン
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        let toolBarBtn = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(doneBtn))
        toolBar.items = [toolBarBtn]
        limitTextField.inputAccessoryView = toolBar
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.timeZone = NSTimeZone.local
        datePickerView.locale = Locale(identifier: "MDY")
        textField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
    }
    
    //datepickerが選択されたらtextfieldに表示
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd";
        limitTextField.text = dateFormatter.string(from: sender.date)
    }
    
    //toolbarのdoneボタン
    @objc func doneBtn(){
        limitTextField.resignFirstResponder()
    }
    @IBAction func save(_ sender: Any) {
        let newTodo = Todo()
        newTodo.todo = todoTextField.text!
        newTodo.content = shousaiTextField.text!
        newTodo.date = limitTextField.text!
        
        do{
            try realm.write{
                realm.add(newTodo)
                //
                print("ToDo Saved")
            }
        }catch{
            print("Save is Faild")
        }
    }
    
    
}
