//
//  CoreDataService.swift
//  ToDo
//
//  Created by Nikhil Patel on 2023-02-18.
//

import Foundation
import CoreData

class CoreDataService {
    
    static var shared = CoreDataService()
    
    
    lazy var myFetchedResultController : NSFetchedResultsController<ToDoDB> = {
         
       var fetch =  ToDoDB.fetchRequest()
         fetch.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: true)]
        
        
        
        
        let context = persistentContainer.viewContext
        
        let fetchController = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
         
         return fetchController
         
     }()
     
    

    func insertTaskToDB(todo: ToDo){
     // check if the task is not in the database
        //select * from ToDoDB where task == task and date == date

        let fetchRequest = ToDoDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "task MATCHES [c] %@ AND date == %@", todo.taskName as CVarArg , todo.taskDate as CVarArg)

        do {
        var listOfSimilarTasks =  try persistentContainer.viewContext.fetch(fetchRequest)
            if listOfSimilarTasks.count > 0 {


            }else {
                let newTask = ToDoDB(context: persistentContainer.viewContext)
                newTask.task = todo.taskName
    
                newTask.urgent = todo.isUrgent
                
                newTask.date = todo.taskDate
                newTask.complete = todo.isComplete

                saveContext()
            }
        }
        catch{}
    }

    func updateToDo(toUpdateToDo: ToDo,taskname: String,taskdate: Date ){
        // match the task in the database
           let fetchRequest = ToDoDB.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "task MATCHES [c] %@ AND date == %@", taskname as CVarArg , taskdate as CVarArg)
        //update task
           do {
               let listOfSimilarTasks =  try persistentContainer.viewContext.fetch(fetchRequest)
               if let task = listOfSimilarTasks.first{

                   task.task = toUpdateToDo.taskName
                   task.urgent = toUpdateToDo.isUrgent
                   task.date = toUpdateToDo.taskDate
                   task.complete = toUpdateToDo.isComplete
                   
                   saveContext()

               }else {
                  
               }
           }
           catch{}

    }

    func getAllToDos() -> [ToDoDB]{
        // select * from ToDoDB
        // order By

        var todos = [ToDoDB]()
        let fetchRequest = ToDoDB.fetchRequest()

        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: true)]

        do{
            todos = try persistentContainer.viewContext.fetch(fetchRequest)

        }catch {


        }

        return todos


    }

    func deleteToDo(todoToDelete: ToDoDB){

        persistentContainer.viewContext.delete(todoToDelete)
        saveContext()

    }
//
    lazy var persistentContainer: NSPersistentContainer = {
         
            let container = NSPersistentContainer(name: "ToDo")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                   
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
        // MARK: - Core Data Saving support
        
        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

}
