//
//  EditViewController.swift
//  todo_day2
//
//  Created by Atsuhiro Muroyama on 2022/09/11.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController,UITextFieldDelegate {
    var selectedrowNum: Int!
    var todosInEdit = [Todo]()
    let realm = try! Realm()

    
    var toolBar:UIToolbar!
    
    var usefilter: String!
    @IBOutlet weak var todotextview: UITextField!
    @IBOutlet weak var syousaitextview: UITextField!
    @IBOutlet weak var limittextvire: UITextField!
    @IBOutlet weak var save: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todosInEdit = Array(realm.objects(Todo.self))
        todotextview.text = todosInEdit[selectedrowNum].todo
        syousaitextview.text = todosInEdit[selectedrowNum].content
        limittextvire.text = todosInEdit[selectedrowNum].date
        
        usefilter = todosInEdit[selectedrowNum].todo
        print(todosInEdit[selectedrowNum].todo)
        
        limittextvire.delegate = self
        setupToolbar()
        
    }
    func setupToolbar() {
        //datepicker上のtoolbarのdoneボタン
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        let toolBarBtn = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(doneBtn))
        toolBar.items = [toolBarBtn]
        limittextvire.inputAccessoryView = toolBar
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
        limittextvire.text = dateFormatter.string(from: sender.date)
    }
    
    //toolbarのdoneボタン
    @objc func doneBtn(){
        limittextvire.resignFirstResponder()
    }
    @IBAction func save(_ sender: Any) {
        var min = realm.objects(Todo.self).filter("todo == %@", usefilter)
        let editedtodo = Todo()
        editedtodo.todo = todotextview.text!
        editedtodo.content = syousaitextview.text!
        editedtodo.date = limittextvire.text!
        
        try! realm.write({
            min.first?.todo = todotextview.text!
            min.first?.content = syousaitextview.text!
            min.first?.date = limittextvire.text!
        })


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
