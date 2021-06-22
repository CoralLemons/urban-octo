//
//  ContentView.swift
//  VendingMachine
//
//  Created by Leeann Warren on 6/18/21.
//

/*
 --> Open app
    --> Display the grid of items, text, add money button, current balance label
        -- add money button is clickable
        -- item buttons are not interactable or have a pop-up to tell user to add money
        -- current balance should show accurate balance
            --> update after user has added money
    --> Allow user to purchase item AFTER money has been added
        -- return remainder of balance
        -- do not allow purchase of item if the item's inventory is SOLD OUT
 **/

import SwiftUI

private var SKU: [Int] = [50] // to hold the SKU for population
private var numInStock: [Int] = [50] // to hold the SKU's inventory in stock
private var inventory = [[Int]]() // inventory 2D array holds the item SKU and # left
private var randy = SystemRandomNumberGenerator() // random number generator reference
private var inventoryGenerated = inventoryRelations()
private var rekt = RoundedRectangle(cornerRadius: 35)
private var fiveColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())] // creates 5 columns for the vending machine

struct ContentView: View {
    var body: some View {
        ZStack{ // stack on top
            Image("emptyMachine")
                .scaledToFit() //resize to fit
            VStack{ // stack vertically
                welcomeMessage // invoke the welcomeMessage func
                Spacer() // space out buttons && title'
                patternB() // edit this to be fixed
                addMoney // invoke the addMoney func
            }// end vStack
        }// end zStack
        .background(Color.black)
    } // end body View
    
    var addMoney: some View{
        Button(action: {
            print("Button clicked: add money") // to test if the button is responding
        }, label: {
            HStack{
                Group{
                    Image(systemName: "dollarsign.circle")
                    Text("Add Money")
                } // end group -- add money button and image
                .foregroundColor(.white)
                .font(.title3.bold())
                .background(Color.pink.opacity(0.6).blur(radius: 3.0))
                .padding(.bottom, 25) // pad the bottom
                } // end HStack -- horizontal stacking
            } // end label -- add money
        )// end button -- add money with horizontal stacking label && symbol
    } // end addMoney
    
    var welcomeMessage: some View {
        Text("Welcome!\nPlease insert currency")
            .font(.title2.bold())
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .background(Color.pink.opacity(0.6).blur(radius: 3.0))
            .padding(.all)
    } // end welcomeMessage -- welcome the user with text
    
} // end ContentView

class inventoryRelations {
    var compiledInventory = CompInventory() // create new CompInventory struct
} // end inventoryRelations class -- keeps together inventory related functions

struct patternB: View {
    var body: some View {
    ScrollView{// <-- look into fixing the layout
        LazyVGrid(columns: fiveColumnGrid){
            rekt.fill(Color.green)
            rekt.fill(Color.blue)
            rekt.fill(Color.orange)
            rekt.fill(Color.pink)
            rekt.fill(Color.yellow)
           } // end LazyVGrid
        .padding(.init(top: 50, leading: 10, bottom: 100, trailing: 10)) // test
        }// end ScrollView
    } // end some view
} // end pattern struct -- creates the rectangle shape for it to be stored/displayed

/* ScrollView{ commented out for debugging
   LazyVGrid(columns: fiveColumnGrid){
       RoundedRectangleView()
   }// end LazyVGrid
 */

struct CompInventory {
    func populateInventory() {
        @State var randomSKU = Int.random(in: 10000..<99999, using: &randy)
        @State var randomStock = Int.random(in: 1..<10, using: &randy)
        for(SKU, stock) in inventory.enumerated(){ // <-- look into this???
            for currentValues in stock {
                inventory[SKU][0] = randomSKU
                inventory[0][currentValues] = randomStock
                print("Item number: \(SKU) \nIn stock: \(stock)")
            } // end inner for loop - initialize the array of the stock values
        } // end for -- for each item in the array, populate the SKU AND the # in stock
    } // end populateInventory -- use random to populate the SKU and inventory values
    
    func checkStatus(itemRequest:Int) -> (Bool){
        var isStocked: Bool
        var inboundItem: Int = 0
        inboundItem = itemRequest
        isStocked = true; // initialized as stocked, change val when inventory == 0
        
        SKU.forEach{ item in
            if(inboundItem == item){
                if(numInStock[item] > 0){
                    isStocked = true
                } // end if statement -- if the stock is greater than 0, isStocked == T
                else if(numInStock[item] == 0){
                    isStocked = false
                    print("else-if in SKU.forEach has been accessed")
                } // end else if --
                else {
                    isStocked = false
                    print("else in SKU.forEach has been accessed")
                } // default else
            } // end if statement -- if the requested inboundItem matches the current SKU, run the body code
            else{
                isStocked = false;
                print("outer else in SKU.forEach has been accessed")
            } // end else --
        } // end forEach SKU array
        
        // pull data of item from 2D array
        return isStocked
    } // end checkStatus -- checks if the item is in stock
} // end CompInventory --

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //ViewCalculations() -- this works!
    } // end previews
} // end preview
