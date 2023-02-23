//
//  AddTaskViewController.swift
//  ToDo
//
//  Created by Nikhil Patel on 2023-02-18.
//

import UIKit
protocol AddingDelegate {
    func taskAdded(todo : ToDo);
    func taskDidCancel();
}
class AddTaskViewController: UIViewController {
    var delegate : AddingDelegate?
    
    @IBOutlet weak var taskView: UITextView!
    
    @IBOutlet weak var isUrgent: UISwitch!
    
    @IBOutlet weak var taskDate: UIDatePicker!
    

    
        @IBAction func CancelBtn(_ sender: Any) {
        
            self.navigationController?.popViewController(animated: true)
    }

    @IBAction func SaveBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add this task", message: "Are you sure you want to save this task?", preferredStyle: .alert)
        
        let  saveAction = UIAlertAction(title: "Yes", style: .default) { action in
 
            let insertedTask = ToDo(task: self.taskView.text, urgent: self.isUrgent.isOn, complete: false, date: self.taskDate.date)
            CoreDataService.shared.insertTaskToDB(todo: insertedTask)
            self.delegate?.taskAdded(todo: insertedTask)
            self.navigationController?.popViewController(animated: true)
            
        }
        
         let cancelAction = UIAlertAction(title: "No", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        
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
