//
//  ViewController.swift
//  NurseeSecondAttempt
//
//  Created by eleonora elefante on 18/02/2020.
//  Copyright © 2020 Eleonora Elefante. All rights reserved.
//

import UIKit

typealias Action = (_ x: Patient)->()

class PatientCell: UITableViewCell {
    
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var roomNumber: UILabel!
    @IBOutlet weak var surgeryDateLabel: UILabel!
    @IBOutlet weak var clinicFieldButton: UIButton!
    
}

class MainViewController: UIViewController, UISearchResultsUpdating  {
    
    
    var patientsArray : [PatientEntity] = []
    var filteredDataModel : [PatientEntity] = []
    //
    //    var patientSelected: PatientEntity?
    
    @IBOutlet weak var patientsTableView: UITableView!
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light 
        patientsArray = PatientDatabase.instance.getAllData()
        filteredDataModel = patientsArray
        
        //        NotificationCenter.default.addObserver(self,selector: Selector(("refreshTable")),name: NSNotification.Name(rawValue: "refresh"),object: nil)
        
        
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search rooms"
        searchController.searchBar.barTintColor = #colorLiteral(red: 0, green: 0.6784591675, blue: 0.5461321473, alpha: 1)
        searchController.searchBar.layer.borderColor = .none
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.searchBar.sizeToFit()
        
        navigationItem.searchController = searchController
        
        patientsTableView.dataSource = self
        patientsTableView.delegate = self
        patientsTableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        patientsArray = PatientDatabase.instance.getAllData()
        patientsTableView.dataSource = self
        patientsTableView.delegate = self
        patientsTableView.reloadData()
        
    }
    @objc func refreshTable(notification:NSNotification){
        patientsTableView.reloadData()
    }
    
    
    @IBAction func sortListByDate(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Sort by:", message: nil, preferredStyle: .actionSheet)
        
        
        let name = UIAlertAction(title: "Name", style:.default) { action in
            self.filteredDataModel.sort(by: {$0.name! < $1.name! })
            
            self.patientsTableView.reloadData()
        }
        let lastSeen = UIAlertAction(title: "Surgery Date", style: .default) { action in
            self.filteredDataModel.sort(by: {$0.date! < $1.date! })
            self.patientsTableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(name)
        actionSheet.addAction(lastSeen)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text == nil || searchController.searchBar.text?.isEmpty == true {
            filteredDataModel = patientsArray
            patientsTableView.reloadData()
            return
        }
        
        if let searchText = self.searchController.self.searchBar.text {
            
            filteredDataModel = patientsArray.filter { (patient) -> Bool in
                
                patient.room!.lowercased().contains(searchText.lowercased())
            }
            
            
            patientsTableView.reloadData()
        }
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.allowsSelection = true
        return filteredDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "patientCell", for: indexPath) as! PatientCell
        
        cell.patientName?.text = filteredDataModel[indexPath.row].name! + " " + (filteredDataModel[indexPath.row].surname!) + "."
        cell.roomNumber?.text = filteredDataModel[indexPath.row].room! + "  Bed: "+(filteredDataModel[indexPath.row].bed!)
        cell.surgeryDateLabel?.text = filteredDataModel[indexPath.row].surgeryDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("did select")
//        performSegue(withIdentifier: "performThisSeguePlease", sender: PatientCell.self)


       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let patientDetailVC = storyboard.instantiateViewController(identifier: "patientDetailVC") as! PatientDetailViewController
        
        patientDetailVC.patientSelected = indexPath.row
        self.navigationController?.pushViewController(patientDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            //                patientsArray = PatientDatabase.instance.deleteData()
            PatientDatabase.instance.context.delete(patientsArray[indexPath.row])
            patientsArray.remove(at: indexPath.row)
            filteredDataModel = patientsArray
            
            saveItems()
            
            
            numberOfCell -= 1
            
            patientsTableView.reloadData()
        }
    }
    
    func saveItems(){
        do{
            try PatientDatabase.instance.context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func segue() {
        
         print("segue performed")
        
      performSegue(withIdentifier: "performThisSeguePlease", sender: PatientCell.self)
        
       
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addPatient" {
            let vc = segue.destination as! AddPatientViewController
            
            //             vc.callbackAction = modalAction()
            
        } else if segue.identifier == "performThisSeguePlease" {
            let vc2 = segue.destination as! PatientDetailViewController
            
        }
    }
}



