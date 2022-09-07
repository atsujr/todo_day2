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
    
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var shousaiTextField: UITextField!
    @IBOutlet weak var limitTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func save(_ sender: Any) {
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
