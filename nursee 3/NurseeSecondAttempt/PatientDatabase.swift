//
//  PatientDatabase.swift
//  NurseeSecondAttempt
//
//  Created by eleonora elefante on 02/03/2020.
//  Copyright © 2020 Eleonora Elefante. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PatientDatabase {
    static let instance = PatientDatabase()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func savePatientData(name: String, surname: String, room: String, bed: String, surgeryDate: String, date: Date, check1: Bool, check2: Bool, check3: Bool, check4: Bool, check5: Bool) {
        
        let patient1 = NSEntityDescription.insertNewObject(forEntityName: "PatientEntity", into: context) as! PatientEntity
        patient1.name = name
        patient1.surname = surname
        patient1.room = room
        patient1.bed = bed
        patient1.surgeryDate = surgeryDate
        patient1.date = date
//        patient1.check1 = check1
//        patient1.check2 = check2
//        patient1.check3 = check3
//        patient1.check4 = check4
//        patient1.check5 = check5
        
        
        
       
        
        do{
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    func getAllData() -> [PatientEntity]{
        
        var patientArray = [PatientEntity]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PatientEntity")
        do{
            patientArray = try context.fetch(fetchRequest)as! [PatientEntity]
        } catch let error{
            print(error.localizedDescription)
        }
        return patientArray
    }
    
    func deleteData() -> [PatientEntity]{
        var patientsArray = [PatientEntity]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PatientEntity")
        
        
        do{
            patientsArray = try context.fetch(fetchRequest)as! [PatientEntity]
            for patient in patientsArray as! [NSManagedObject] {
                context.delete(patient)
                
            }
            
        } catch let error{
            print(error.localizedDescription)
        }
        do{
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
        return patientsArray
    }
    
}






