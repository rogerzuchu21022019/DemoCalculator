//
//  ViewController.swift
//  DemoCalculator
//
//  Created by Vu Thanh Nam on 23/05/2022.
//

import UIKit
import CoreData
enum Operations:String {
    case Add = "+"
    case Sub = "-"
    case Multi = "x"
    case Div = "/"
    case Percent = "%"
    case Null = "Null"
}

var arrResult:[Calculator1] = []
let appDelegate = UIApplication.shared.delegate as! AppDelegate
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//    var arrResult:[String] = []
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var runningValue = ""
    var currentOperation :Operations = .Null
    let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var lblResultDisplay: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self
        requestFetch()
        myTable.reloadData()
    }
    func initCoreData(){

        let entity = NSEntityDescription.entity(forEntityName: "Calculator1", in: context)
        let newCalculator = Calculator1(entity: entity!, insertInto: context)
        newCalculator.result = result
        newCalculator.leftValue = leftValue
        newCalculator.rightValue = rightValue
        newCalculator.runningValue = runningValue
        print("\(newCalculator.runningValue!)")
        print("\(newCalculator.rightValue!)")
        print("\(newCalculator.leftValue!)")
        print("\(newCalculator.result!)")
        do {
            try context.save()
        } catch  {
        }
    }
    
    func requestFetch(){
       
        let request = NSFetchRequest<Calculator1>(entityName: "Calculator1")
        do {
            arrResult = try context.fetch(request)
        } catch {
            print("error")
        }
    }
    
    @IBAction func btnDot(_ sender: UIButton) {
        if runningValue.count <= 7 {
                runningValue += "."
                lblResultDisplay.text = runningValue
        }
    }
//    @IBAction func btnPercent(_ sender: UIButton) {
//        if runningValue.count > 0 {
//            result = "\(Double(runningValue)! / 100)"
//            rightValue = ""
//            leftValue = result
//            lblResultDisplay.text = result
//        }
//
//    }
    @IBAction func btnPercent(_ sender: UIButton) {
        if runningValue.count > 0 {
            operations(operation: .Percent)
        }
      
    }
    @IBAction func btnAllClear(_ sender: UIButton) {
        leftValue = ""
        rightValue = ""
        result = "0"
        runningValue = ""
        currentOperation = .Null
        lblResultDisplay.text = "0"
    }
    @IBAction func btnClear(_ sender: UIButton) {
        if lblResultDisplay.text!.count > 0 {
            lblResultDisplay.text?.removeLast()
            if lblResultDisplay.text!.count == 0{
                lblResultDisplay.text = "0"
            }
        }
    }
    @IBAction func btnAdd(_ sender: UIButton) {
        if runningValue.count > 0 {
            operations(operation: .Add)
        }
        
    }
    @IBAction func btnSub(_ sender: UIButton) {
        if runningValue.count > 0{
            operations(operation: .Sub)
        }
    }
    @IBAction func btnDiv(_ sender: UIButton) {
        if runningValue.count > 0{
            operations(operation: .Div)
        }
    }
    @IBAction func btnMulti(_ sender: UIButton) {
        if runningValue.count > 0 {
            operations(operation: .Multi)
        }
    }
    @IBAction func btnEqual(_ sender: UIButton) {
        if runningValue.count > 0 {
            operations(operation: currentOperation)
    //        arrResult.insert("\(result)", at: 0)
            initCoreData()
            requestFetch()
            myTable.reloadData()
        }
   
      
    }
    @IBAction func btnNumber(_ sender: UIButton) {
        if runningValue.count <= 8 {
            runningValue += "\(sender.titleLabel!.text!)"
            lblResultDisplay!.text = runningValue
        }
    }
    
    func operations(operation:Operations){
        if runningValue.count > 0{
            if currentOperation != .Null{
                if runningValue != "" {
                    rightValue = runningValue
                    runningValue = ""
                    if currentOperation == .Add{
                        result = "\(Double(leftValue)!  + Double(rightValue)!)"
                    }else if currentOperation == .Sub{
                        result = "\(Double(leftValue)! - Double(rightValue)!)"
                    }else if currentOperation == .Multi{
                        result = "\(Double(leftValue)! * Double(rightValue)!)"
                    }else if currentOperation == .Div{
                        result = "\(Double(leftValue)! /  Double(rightValue)!)"
                    }else if currentOperation == .Percent {
                        
                        let result1  = "\(Double(leftValue)! / 100)"
                        let result2  = "\(Double(rightValue)! / 100 )"
                        if  currentOperation == .Add{
                            result = "\(Double(result1)! + Double(result2)!)"
                        }
                        
                        else if currentOperation == .Sub{
                        result = "\(Double(result1)! - Double(result2)!)"
                        }
                    }
                    
                    
                    leftValue = result
                    lblResultDisplay.text = "\(Double(result)!)"
                }
                currentOperation = operation
            }else{
                leftValue = runningValue
                runningValue = ""
                currentOperation = operation
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HistoryCell
        let result = arrResult[indexPath.row]
        cell.lblResult.text = result.result
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        requestFetch()
        myTable.reloadData()
    }
}

