//
//  patientData.swift
//  NurseeSecondAttempt
//
//  Created by eleonora elefante on 22/02/2020.
//  Copyright © 2020 Eleonora Elefante. All rights reserved.
//

import Foundation
import UIKit

let defaults = UserDefaults.standard

class Patient {
//: NSObject, NSCoding {
    
    var name: String
    var surname: String
    var date: Date
    var surgeryDate: String
    var roomNumber: String
    var id: Int
    
    init(name: String, surname: String, date: Date,surgeryDate: String, roomNumber: String, id: Int) {
       
        self.name = name
        self.surname = surname
        self.date = date
        self.surgeryDate = surgeryDate
        self.roomNumber = roomNumber
        self.id = id
        
    }
}
    

//    required init?(coder decoder: NSCoder) {
//        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
//        self.surname = decoder.decodeObject(forKey: "surname") as? String ?? ""
//        self.date = (decoder.decodeObject(forKey: "date") as? Date ?? nil)
//        self.surgeryDate = decoder.decodeObject(forKey: "surgeryDateString") as? String ?? ""
//        self.roomNumber =  decoder.decodeObject(forKey: "room") as? String ?? ""
//        self.id = decoder.decodeObject(forKey: "id") as? Int ?? 0
//
//      }
//
//    func encode(with coder: NSCoder) {
//        coder.encode(self.name, forKey: "name")
//        coder.encode(self.surname, forKey: "surname")
//        coder.encode(self.date, forKey: "DATE")
//        coder.encode(self.surgeryDate, forKey: "surgeryDateString")
//        coder.encode(self.roomNumber, forKey: "room")
//        coder.encode(self.id, forKey: "id")
//    }
    
struct Checklist {
    var exams: [String]
    var exams2: [Protocol]
}

struct Protocol {
    var examName : String
    var examChecked: Bool
}


var patients = [Patient]()






