//
//  AddPatientViewController.swift
//  NurseeSecondAttempt
//
//  Created by eleonora elefante on 19/02/2020.
//  Copyright © 2020 Eleonora Elefante. All rights reserved.


// ----> !!!READ HERE!!! <----
//what still doesn't work in this view:
//if you add an "additional exam" than you can't see that kind of cell anymore unless you check the last cell. Why?
//it's possible to delete every kind of cell, but actually the "additional exam cell" shouldn't be deleted
//the done button should be disable until every text filed is filled

import UIKit
import CoreData
import UserNotifications

var protocols : [String] = ["EKG","Haemato-chemical tests", "X-ray", "Anaesthesiological consultation", "Informed consent to the surgery"]

var patientProtocols = protocols

var numberOfCell : Int = protocols.count + 1
var checked: Bool = false

var booleansArray : [Bool] = [false, false, false, false,false]

//creating a class to custmomize our cell. Inside this block it's possible to make connection from the storyboard
class CheckListCell: UITableViewCell {
    
    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var uncheckedButton: UIButton!
    @IBOutlet weak var examNameLabel: UILabel!
    @IBOutlet weak var additionalExamTextField: UITextField!
    
    

    
    
    
    var cellChecked: Bool!
    
    
    
//        @IBAction func addExam(_ sender: UITextField) {
////            should try with editing did end !!!!
////
////
////            examNameLabel.text = additionalExamTextField.text
////                        protocols.append(additionalExamTextField.text!)
////                numberOfCell += 1
////
////            uncheckedButton.setTitle( "◎", for: .normal)
////            checkMarkButton.setTitle("◉", for: .normal)
////            examNameLabel.isHidden = false
////            additionalExamTextField.isHidden = true
////
////
////
////
////            print("number of protocols: \(protocols.count) 1 print")
////            print("number of cell: \(numberOfCell) 1 print")
////            print(protocols)
//        }
    @IBAction func gg(_ sender: Any) {

        
                examNameLabel.text = additionalExamTextField.text
                            protocols.append(additionalExamTextField.text!)
                    numberOfCell += 1
        
                uncheckedButton.setTitle( "◎", for: .normal)
                checkMarkButton.setTitle("◉", for: .normal)
                examNameLabel.isHidden = false
                additionalExamTextField.isHidden = true
        
        
        
        
                print("number of protocols: \(protocols.count) 1 print")
                print("number of cell: \(numberOfCell) 1 print")
                print(protocols)
    }
    
    
    @IBAction func addExam(_ sender: UITextField) {
        
        protocols.append(additionalExamTextField.text!)
        
        
    }
    
    @IBAction func recreateTheAdditionalCell(_ sender: UITextField) {
        //        not working
        patientProtocols.append(additionalExamTextField.text!)
        
        print("number of protocols: \(protocols.count) 2 print")
        print("number of cell: \(numberOfCell) 2 print")
        print(protocols)
        
    }
    
    @IBAction func checkItem(_ sender: UIButton) {
        
        checked = true
        
        uncheckedButton.isHidden = true
        uncheckedButton.isEnabled = false
        
        checkMarkButton.isHidden = false
        checkMarkButton.isEnabled = true
        
        cellChecked = true
        
  
         

    }
    
    
    @IBAction func uncheckItem(_ sender: Any) {
        
          checked = false
        uncheckedButton.isHidden = false
        uncheckedButton.isEnabled = true
        
        checkMarkButton.isHidden = true
        checkMarkButton.isEnabled = false
        
        
        cellChecked = false
       
        
    }
}

class AddPatientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var callbackAction: Action?
    
    @IBOutlet weak var surgeryDateTextView: UITextView!
    @IBOutlet weak var surgeryDatePicker: UIDatePicker!
    @IBOutlet weak var checkListTableView: UITableView!
    @IBOutlet weak var patientName: UITextField!
    @IBOutlet weak var patientSurname: UITextField!
    @IBOutlet weak var patientRoomNumber: UITextField!
    @IBOutlet weak var patientBedNumber: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    @IBAction func datapickeraction(_ sender: Any) {
        scheduleNotification()
    }
    @IBAction func buttonaction(_ sender: Any) {
        scheduleNotification()
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light 
        
        
        
        doneButton.isEnabled = false
        doneButton.tintColor = .gray
        
        checkListTableView.delegate = self
        checkListTableView.dataSource = self
        
        patientSurname.delegate = self
        
        patientProtocols = protocols
        
        //        checkForPatientInfo()
        //        doneButton.isEnabled = false
        //        doneButton.isOpaque = false
        //        doneButton.alpha = 0.65
        
        
        patientRoomNumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        patientSurname.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        patientName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
        
        
        self.hideKeyboardWhenTappedAround()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //to keep data even when the view disappears
    
//    override func viewDidDisappear(_ animated: Bool) {
//        PatientDatabase.instance.savePatientData(name: patientName.text!, surname: patientSurname.text!, room: patientRoomNumber.text!, bed: patientBedNumber.text!, surgeryDate: surgeryDateTextView.text!, date: surgeryDatePicker.date)
//    }
//    
    
    @IBAction func savePatientInfoWithUserDefault(_ sender: Any) {
        //        savePatientInfo()
        
    }
    
    @IBAction func takeSurgeryDate(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: surgeryDatePicker.date)
        surgeryDateTextView.text = "\(strDate)"
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        
        print("ue")
        
        PatientDatabase.instance.savePatientData(name: patientName.text!, surname: patientSurname.text!, room: patientRoomNumber.text!, bed: patientBedNumber.text!, surgeryDate: surgeryDateTextView.text!, date: surgeryDatePicker.date, check1: checked, check2: checked, check3: checked, check4: checked, check5: checked)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(identifier: "mainVC") as! MainViewController
        
        
        self.navigationController?.pushViewController(mainVC, animated: true)
        
        
    }
    
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent() //The notification's content
        content.title = "Go To Check!"
        content.body = "Patient in room\(patientRoomNumber.text!),bed\(patientBedNumber.text!) \nHas to be operated tomorrow!"
        content.sound = UNNotificationSound.default

        let dateComponent = surgeryDatePicker.calendar.dateComponents([.day, .hour, .minute], from: surgeryDatePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let notificationReq = UNNotificationRequest(identifier: "identifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(notificationReq, withCompletionHandler: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfCell
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = patientSurname.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 1
        
    }
    //  with this function the done button is not enabled until the users fill the text fields, still need to to the same with the surgeryDateTextView
    @objc func textFieldDidChange(_ textField: UITextField) {
        if patientName.text != "", patientSurname.text != "", patientRoomNumber.text != "" {
            doneButton.isEnabled = true
            doneButton.tintColor = #colorLiteral(red: 0.298600167, green: 0.6644408703, blue: 0.5506110191, alpha: 1)
            print("not empty")
        } else if patientName.text == "", patientSurname.text == "", patientRoomNumber.text == "" {
            doneButton.isEnabled = false
            doneButton.tintColor = .gray
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == protocols.count {
            let additionalCell = tableView.dequeueReusableCell(withIdentifier: "checkCell",for: indexPath)
                as! CheckListCell
            
            additionalCell.additionalExamTextField.isHidden = false
            additionalCell.uncheckedButton.setTitle("+", for: .normal)
            additionalCell.examNameLabel.isHidden = true
            additionalCell.target(forAction: "addExam", withSender: AnyClass.self)
            additionalCell.target(forAction: "reloadTableView", withSender: AnyClass.self)
            
            
            
            return additionalCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkCell",for: indexPath)
            as! CheckListCell
        
        cell.uncheckedButton.setTitle("◎", for: .normal)
        cell.checkMarkButton.setTitle("◉", for: .normal)
        cell.examNameLabel?.text = protocols[indexPath.row]
        checkListTableView.reloadRows(at: [indexPath], with: .none)
        cell.target(forAction: "checkItem", withSender: UIButton.self)
        cell.target(forAction: "uncheckItem", withSender: UIButton.self)
        if cell.uncheckedButton.isEnabled == true {
            booleansArray[indexPath.row] = true
//            reloadTableView()
        } else {
            booleansArray[indexPath.row] = false
        }
        
        return cell
        
        checkListTableView.reloadRows(at: [indexPath], with: .none)
        checkListTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkCell",for: indexPath)
            as! CheckListCell
        
        print("You selected cell #\(indexPath.row)!")
        checked = false
        cell.cellChecked = false
        
        print(checked)
        
        checkListTableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if indexPath.row == protocols.count {
            return false
        } else {
            return true
        }
    }
    
    // Swipe on the cell to delete:
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) && (indexPath.row != protocols.count){
            
            protocols.remove(at: indexPath.row)
            patientProtocols.remove(at: indexPath.row)
            
            numberOfCell -= 1
            
            checkListTableView.reloadData()
        }
    }
    
    
    func reloadTableView() {
        
        checkListTableView.reloadData()
        
        
    }
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


