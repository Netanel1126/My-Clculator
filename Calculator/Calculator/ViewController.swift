//
//  ViewController.swift
//  Calculator
//
//  Created by admin on 24/07/2018.
//  Copyright © 2018 Netanel1126. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numLabel: UILabel!
    
    var sum:Double = 0;
    var operation = 12;
    var num:Double = 0;
    var numString = ""
    var dotExsist = false
    var changeLabel = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numLabel.adjustsFontSizeToFitWidth = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calcNumbers(){
        switch operation {
        case 10://Multiply
            sum *= num;
        case 11://Divade
            if num == 0{
                zeroError();
            }else{
                sum /= num;
            }
        case 12://Add
            sum += num;
        case 13://sub
            sum -= num;
        default:
            print("DEFAULT")
        }
        numLabel.text = String(sum);
    }
    
    func insertComma(str:String)->String{
        var i = 3;
        var newString = str
        var affterTheDot = ""
        
        if newString.range(of: ".") != nil{
            let dotIndex = newString.range(of: ".")!.lowerBound
            affterTheDot = newString.suffix(from: dotIndex).description
            newString = str[str.startIndex..<dotIndex].description
        }
        
        while(newString.count > i){
            newString.insert(",", at: newString.index(newString.endIndex, offsetBy: -i))
            i += 4;
        }
        return newString + affterTheDot;
    }
    
    func zeroError(){
        let alert = UIAlertController(title: "Math Error - You Cannot Divade By Zero", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func number(_ sender: UIButton) {
        if(changeLabel){
            numLabel.text = "";
            numString = ""
            changeLabel = false
        }
        
        if(sender.tag == 14 && numString.count > 0){
            var tempNum = Double(numString)! * -1;
            if (tempNum.truncatingRemainder(dividingBy: 1)) == 0{
                 numString = String(format: "%.0f", tempNum)
            }else{
                numString = String(tempNum)
            }
        }else if(sender.tag != 14){
            numString += String(sender.tag)
        }
        numLabel.text = insertComma(str: numString)
    }
    
    @IBAction func showSum(_ sender: UIButton) {
        num = Double(numString)!
        calcNumbers()
    }
    
    @IBAction func deleteLastString(_ sender: UIButton) {
         numString.remove(at:(numString.index(before: (numString.endIndex))))
        numLabel.text = insertComma(str: numString)

        if numLabel.text?.count == 0{
            numLabel.text = "0"
            changeLabel = true
        }
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        numLabel.text = "0";
        sum = 0;
        operation = 12;
        num = 0;
        numString = ""
        dotExsist = false;
        changeLabel = true;
    }
    
    @IBAction func addOperation(_ sender: UIButton) {
        if changeLabel == false{
            if numString.last! == "."{
                 numString.remove(at:(numString.index(before: (numString.endIndex))))
            }
            num = Double(numString)!
            calcNumbers()
        }
        operation = sender.tag
        changeLabel = true
    }
    @IBAction func addDot(_ sender: UIButton) {
        if(dotExsist == false){
            numString += "."
        }
    }
    
    
}
