//
//  ExamDatabase.swift
//  NurseeSecondAttempt
//
//  Created by eleonora elefante on 03/03/2020.
//  Copyright © 2020 Eleonora Elefante. All rights reserved.
//

import Foundation
import UIKit
import CoreData


//class ExamDatabase {
//    
//    static let instance = ExamDatabase()
//    
//    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    
//    func saveExamData(examName: String, checked: Bool) {
//        
//        let exam1 = NSEntityDescription.insertNewObject(forEntityName: "ExamEntity", into: context) as! ExamEntity
//        
//        exam1.examName = examName
//        exam1.checked = checked
//        
//        do{
//            try context.save()
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//    
//    
//    func getExamData() -> [ExamEntity]{
//        
//        var examsArray = [ExamEntity]()
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ExamEntity")
//        
//        
//        do{
//            examsArray = try context.fetch(fetchRequest)as! [ExamEntity]
//        } catch let error{
//            print(error.localizedDescription)
//        }
//        return examsArray
//    }
//    
////    extension ExamDatabase {
////
////        @NSManaged var examName: String?
////        @NSManaged var
////
////
////
//    }
//    
//
//    

