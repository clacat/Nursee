//
//  PatientDetailViewController.swift
//  NurseeSecondAttempt
//
//  Created by eleonora elefante on 19/02/2020.
//  Copyright © 2020 Eleonora Elefante. All rights reserved.
//

import UIKit

var viewIsEditing : Bool = false
// var patientSelected: PatientEntity?

class checkListCell2: UITableViewCell {
   
    @IBOutlet weak var itemUncheckedButton: UIButton!
    @IBOutlet weak var itemCheckedButton: UIButton!
    @IBOutlet weak var examName2: UILabel!
    @IBOutlet weak var additionalExamTF2: UITextField!
    

    @IBAction func checkItem(_ sender: Any) {
        
        if viewIsEditing == true {
            itemUncheckedButton.isHidden = true
            itemUncheckedButton.isEnabled = false
            
            itemCheckedButton.isHidden = false
            itemCheckedButton.isEnabled = true
            
        }
    }
    
    @IBAction func uncheckItem(_ sender: Any) {
        
        if viewIsEditing == true {
            itemCheckedButton.isHidden = true
            itemCheckedButton.isEnabled = false
            
            itemUncheckedButton.isHidden = false
            itemUncheckedButton.isEnabled = true
            
        }
    }
}

class PatientDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var callbackAction2: Action?
    var patientsArray : [PatientEntity] = []
//    var patientSelected: Patient?
    
    var patientSelected: Int = 0
    
    @IBOutlet weak var checkListTableView2: UITableView!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientSurnameLabel: UILabel!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var bedNumberLabel: UILabel!
    @IBOutlet weak var surgeryDateTextView2: UITextView!
    
    @IBOutlet weak var surgeryDatePicker: UIDatePicker!
    
    @IBOutlet weak var patientNameTextField: UITextField!
    @IBOutlet weak var patientSurnameTextField: UITextField!
    @IBOutlet weak var patientRoomTextField: UITextField!
    @IBOutlet weak var patientBedTextField: UITextField!
    
   
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light 
        
         patientsArray = PatientDatabase.instance.getAllData()
        
        checkListTableView2.delegate = self
        checkListTableView2.dataSource = self
        
        
        
        patientNameLabel.text = patientsArray[patientSelected].name
        patientSurnameLabel.text = patientsArray[patientSelected].surname
        roomNumberLabel.text = patientsArray[patientSelected].room
        surgeryDateTextView2.text = patientsArray[patientSelected].surgeryDate
        bedNumberLabel.text = patientsArray[patientSelected].bed
        
        patientSurnameTextField.delegate = self
        
        editButton.title = "Edit"
        
//        doneButton.isHidden = true
//        doneButton.isEnabled = false
        
        hideKeyboardWhenTappedAround2()
        
 
        
        print(checked)
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = patientSurnameTextField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 1
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientProtocols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkCell2")
            as! checkListCell2
        
        cell.examName2?.text = patientProtocols[indexPath.row]
        cell.itemCheckedButton.setTitle("◉", for: .normal);
        cell.itemUncheckedButton.setTitle("◎", for: .normal)
        
//        print(patientsArray[indexPath.row].check1)
//        print(patientsArray[indexPath.row].check2)
//        print(patientsArray[indexPath.row].check3)
//        print(patientsArray[indexPath.row].check4)
//        print(patientsArray[indexPath.row].check5)
//        print("\n")
//
//        if patientsArray[indexPath.row].check1 == true {
//            cell.itemCheckedButton.isHidden = false
//            cell.itemCheckedButton.isHidden = true
//        } else if patientsArray[indexPath.row].check1 == false {
//
//            cell.itemCheckedButton.isHidden = true
//            cell.itemCheckedButton.isHidden = false
//        }
//
//        if patientsArray[indexPath.row].check2 == true {
//                  cell.itemCheckedButton.isHidden = false
//                  cell.itemCheckedButton.isHidden = true
//              } else if patientsArray[indexPath.row].check2 == false {
//
//                  cell.itemCheckedButton.isHidden = true
//                  cell.itemCheckedButton.isHidden = false
//              }
//
//        if patientsArray[indexPath.row].check3 == true {
//                  cell.itemCheckedButton.isHidden = false
//                  cell.itemCheckedButton.isHidden = true
//              } else if patientsArray[indexPath.row].check3 == false {
//
//                  cell.itemCheckedButton.isHidden = true
//                  cell.itemCheckedButton.isHidden = false
//              }
//        if patientsArray[indexPath.row].check4 == true {
//                         cell.itemCheckedButton.isHidden = false
//                         cell.itemCheckedButton.isHidden = true
//                     } else if patientsArray[indexPath.row].check4 == false {
//
//                         cell.itemCheckedButton.isHidden = true
//                         cell.itemCheckedButton.isHidden = false
//                     }
//        if patientsArray[indexPath.row].check5 == true {
//                               cell.itemCheckedButton.isHidden = false
//                               cell.itemCheckedButton.isHidden = true
//                           } else if patientsArray[indexPath.row].check5 == false {
//
//                               cell.itemCheckedButton.isHidden = true
//                               cell.itemCheckedButton.isHidden = false
//                           }

       
        
        return cell
        
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
           
           if indexPath.row == patientProtocols.count {
               return false
           } else {
               return true
           }
       }
    
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) && (indexPath.row != patientProtocols.count){
                   
                   patientProtocols.remove(at: indexPath.row)
                   
                   tableView.reloadData()
    }
}
  
    @IBAction func editDataAction(_ sender: UIBarButtonItem) {
        

        editButton.isEnabled = false
        
        
        patientNameLabel.isHidden = true
        patientNameTextField.isHidden = false
        patientNameTextField.text = patientNameLabel.text
        
        patientSurnameLabel.isHidden = true
        patientSurnameTextField.isHidden = false
        patientSurnameTextField.text = patientSurnameLabel.text
        
        roomNumberLabel.isHidden = true
        patientRoomTextField.isHidden = false
        patientRoomTextField.text = roomNumberLabel.text
        
       bedNumberLabel.isHidden = true
       patientBedTextField.isHidden = false
       patientBedTextField.text = bedNumberLabel.text
        
        surgeryDatePicker.isHidden = false

//        viewIsEditing = true


                if viewIsEditing == true {
                
                        
        //        editButton.isHidden = false
                editButton.isEnabled = true
                        
                patientNameLabel.text = patientNameTextField.text
                patientNameTextField.isHidden = true
                patientNameLabel.isHidden = false
                
                patientSurnameLabel.text = patientSurnameTextField.text
                patientSurnameLabel.isHidden = false
                patientSurnameTextField.isHidden = true
                
                roomNumberLabel.text = patientRoomTextField.text
                patientRoomTextField.isHidden = true
                roomNumberLabel.isHidden = false
                
                bedNumberLabel.text = patientBedTextField.text
                patientBedTextField.isHidden = true
                bedNumberLabel.isHidden = false
                
                surgeryDatePicker.isHidden = true
                
                print("edit retapped")
                }
        
        
        print("edit tapped")
   
    }
    
    
    func disableEdit() {
        
        
//        if viewIsEditing == true {
//
////                doneButton.isHidden = true
////                doneButton.isEnabled = false
//
//        //        editButton.isHidden = false
//                editButton.isEnabled = true
//
//                patientNameLabel.text = patientNameTextField.text
//                patientNameTextField.isHidden = true
//                patientNameLabel.isHidden = false
//
//                patientSurnameLabel.text = patientSurnameTextField.text
//                patientSurnameLabel.isHidden = false
//                patientSurnameTextField.isHidden = true
//
//                roomNumberLabel.text = patientRoomTextField.text
//                patientRoomTextField.isHidden = true
//                roomNumberLabel.isHidden = false
//
//                bedNumberLabel.text = patientBedTextField.text
//                patientBedTextField.isHidden = true
//                bedNumberLabel.isHidden = false
//
//                surgeryDatePicker.isHidden = true
//
//        }
        
    }
    
    @IBAction func saveChangesButton(_ sender: Any) {
        
       
        
        if viewIsEditing == true {
        
                
//        editButton.isHidden = false
        editButton.isEnabled = true
                
        patientNameLabel.text = patientNameTextField.text
        patientNameTextField.isHidden = true
        patientNameLabel.isHidden = false
        
        patientSurnameLabel.text = patientSurnameTextField.text
        patientSurnameLabel.isHidden = false
        patientSurnameTextField.isHidden = true
        
        roomNumberLabel.text = patientRoomTextField.text
        patientRoomTextField.isHidden = true
        roomNumberLabel.isHidden = false
        
        bedNumberLabel.text = patientBedTextField.text
        patientBedTextField.isHidden = true
        bedNumberLabel.isHidden = false
        
        surgeryDatePicker.isHidden = true
        
//        PatientDatabase.instance.savePatientData(name: patientNameTextField.text!, surname: patientSurnameTextField.text!, room: patientRoomTextField.text!, bed: patientBedTextField.text!, surgeryDate: surgeryDateTextView2.text!, date: surgeryDatePicker.date)
//
//
//        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "refresh"),object: nil,userInfo: nil)
//
//        print("done tapped")
//        self.dismiss(animated: true, completion: nil)
        
        print("edit retapped")
        }
    }
    
    
    
    @IBAction func dismissModal(_ sender: Any) {
//
//        PatientDatabase.instance.savePatientData(name: patientNameTextField.text!, surname: patientSurnameTextField.text!, room: patientRoomTextField.text!, bed: patientBedTextField.text!, surgeryDate: surgeryDateTextView2.text!, date: surgeryDatePicker.date)


//    if you uncomment this line it crashes:
//        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "refresh"),object: nil,userInfo: nil)
//
            print("done tapped")
            self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func editSurgeryDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: surgeryDatePicker.date)
        surgeryDateTextView2.text = "\(strDate)"
        
    }
    
    
    
   
    
//    override func viewDidDisappear(_ animated: Bool) {
//
//        let x = Patient(name: patientNameLabel.text!, surname: patientSurnameLabel.text!, surgeryDate: surgeryDateTextView2.text!, roomNumber: roomNumberLabel.text!, bedNumber: bedNumberLabel.text!, id: 0)
//
//    }
}

extension PatientDetailViewController {
    func hideKeyboardWhenTappedAround2() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard2() {
        view.endEditing(true)
    }

}
