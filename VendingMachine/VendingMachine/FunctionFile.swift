//
//  FunctionFile.swift
//  VendingMachine
//
//  Created by Leeann Warren on 6/18/21.
//

import Foundation
import SwiftUI

struct Calculations{
    
    // variables and constants -- properties
    var initialValue:Int = 0; // init value -- keep until later for example help
    
    // view code for this screen
    
    // functions -- methods
    mutating func addNumbers(_num: Int, _num2:Int) -> Int{ // mutating <-- changed to reference self.initialValue to be returned
        self.initialValue = (_num + _num2) // this instance of inital value
        return initialValue // return value -- denoted by '->' and data type following
    } // end addNumbers
    
} // end Calculations struct - logic and math

struct ViewCalculations: View {
    var body: some View {
        var holding:Calculations = Calculations()
        let newNum:Int = holding.addNumbers(_num: 5, _num2: 5)
        return Text("5 + 5 is " + String(newNum))
            .padding()
    } // end body view
} // end ViewCalculations -- allows user to see the calculations

struct Array<Element> {
    
} // end generic array -- paired with protocols this is powerful


