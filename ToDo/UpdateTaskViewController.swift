//
//  UpdateTaskViewController.swift
//  ToDo
//
//  Created by Nikhil Patel on 2023-02-18.
//

import UIKit
protocol UpdatingDelegate {
    func taskUpdated(todo : ToDo);
    func taskUpdateDidCancel();
}
class UpdateTaskViewController: UIViewController {
    var delegate : UpdatingDelegate?
    
    var selectedTask : ToDo?
    var urgentValue : Bool?
    var completeValue : Bool?
    
    @IBOutlet weak var taskView: UITextView!
    
    @IBOutlet weak var isUrgent: UISwitch!
    
    @IBOutlet weak var isComplete: UISwitch!
    
    @IBOutlet weak var taskDate: UIDatePicker!
    
        @IBAction func CancelBtn(_ sender: Any) {
        
            self.navigationController?.popViewController(animated: true)
    }

    @IBAction func SaveBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "Update this task", message: "Are you sure you want to update this task?", preferredStyle: .alert)
        
        let  saveAction = UIAlertAction(title: "Yes", style: .default) { [self] action in
 
            let updatedTask = ToDo(task: self.taskView.text, urgent: self.isUrgent.isOn, complete: self.isComplete.isOn, date: self.taskDate.date)
            CoreDataService.shared.updateToDo(toUpdateToDo: updatedTask, taskname: selectedTask!.taskName, taskdate: selectedTask!.taskDate)
   
            self.delegate?.taskUpdated(todo: updatedTask)
     
            
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
        print(selectedTask!.taskName)
       
            taskView.text = selectedTask?.taskName
            urgentValue = selectedTask?.isUrgent
            isUrgent.isOn = urgentValue!
            completeValue = selectedTask?.isComplete
            isComplete.isOn = completeValue!
            taskDate.date = selectedTask!.taskDate
        
       
        
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
