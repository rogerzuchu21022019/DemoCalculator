//
//  Calculator.swift
//  DemoCalculator
//
//  Created by Vu Thanh Nam on 24/05/2022.
//
import CoreData

@objc(Calculator1)
class Calculator1: NSManagedObject {
    @NSManaged var result:String?
    @NSManaged var leftValue:String?
    @NSManaged var rightValue:String?
    @NSManaged var runningValue:String?
}
