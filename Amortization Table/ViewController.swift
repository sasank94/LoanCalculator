//
//  ViewController.swift
//  Amortization Table
//
//  Created by Ambadasugari, Sasank on 3/12/18.
//  Copyright © 2018 Ambadasugari, Sasank. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var amountPaid: UILabel!
    @IBOutlet weak var interestPaid: UILabel!
    @IBOutlet weak var monthlyPayment: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var years: UISegmentedControl!
   
    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    @IBOutlet weak var Results: UITextView!
    @IBOutlet weak var displayOutlet: UILabel!
    
    var amt : Double!
    var intRate : Double!
    var yrs : Int!
    var balance: Double!
    var payment : Double!
    var paymentNum : Int!
   
   
    @IBAction func sliderChange(_ sender: UISlider) {
        
        var value = Double(slider.value)
        displayOutlet.text = String(format: "%.2f",(value))
    }
    
    
    @IBAction func showResult(_ sender: Any) {
        
        if let chk = Double(amount.text!.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)) as? Double,
           let chk1 = Double(displayOutlet.text!.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)) as? Double,
           let chk2 = Double(monthlyPayment.text!.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)) as? Double
        {
        
          amount.text = amount.text!.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
          displayOutlet.text = displayOutlet.text!.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
          monthlyPayment.text = monthlyPayment.text!.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
          
            
            
        func pow (_ base:Double,_ power:Int) -> Double
        {
            var res : Double = 1
            for _ in 0..<power { res *= base }
            return res
        }
        
        interestPaid.isHidden = false
        amountPaid.isHidden = false
        monthlyPaymentLabel.isHidden = false
        balance = Double(amount.text!)
        
        
        //et n: Double = years! * 12
        if years.selectedSegmentIndex == 0
        {
            yrs = 15
        }
        else if years.selectedSegmentIndex == 1
        {
            yrs = 20
        }
        else
        {
            yrs = 30
        }
        
        
        intRate = Double(displayOutlet.text!)!/12.0
        payment = balance * (intRate*pow((1+intRate),yrs*12)) / (pow((1+intRate),yrs*12)-1)
        monthlyPaymentLabel.text = String(format: "%.2f",payment)
        print("Monthly payment",payment)
        
        //var balance: Double = monthlyPayment
       // print(showResult)
        
        var totInt = 0.0
        
        paymentNum = 1
        
        Results.text = "Pymnt #" + "     " + "Prev Bal" +  "        " + "Interest" + "       " + "Principal" + "       " + "New Bal" + "\n"
            
        while(balance > 0.000001)
        {
            
            Results.text = Results.text + "     "+String(format: "%3d",(paymentNum!))+"         "+String(format: "%7.2f", balance!)+"     "+String(format: "%7.2f", (intRate*balance))+"        "+String(format: "%5.2f", (payment-(intRate*balance)))+"       "+String(format: "%9.2f", ((balance-payment+(intRate*balance)))) + "\n"
            
            print(paymentNum,"  ",balance,"  ",intRate*balance,"  ",payment-(intRate*balance),"  ",balance-payment+(intRate*balance))
            
            paymentNum = paymentNum + 1
            totInt += intRate * balance
            
            balance = balance - (payment + Double(monthlyPayment.text!)!) + (intRate * balance)
            
            
            
        }
        interestPaid.text = String(format: "%.2f",totInt)
        amountPaid.text = String(format: "%.2f",Double(amount.text!)! + totInt)
        print("Total Interest paid",totInt)
        print("Total Amount paid",Double(amount.text!)! + totInt)
       
    
    }
    
    else
    
    {
    let alert = UIAlertController(title: "Bad value entered ", message: "Please check if given values are Double or it is blank value in all text labels", preferredStyle: UIAlertControllerStyle.alert)
    
    // add an action (button)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    
    // show the alert
    self.present(alert, animated: true, completion: nil)
    }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        amount.resignFirstResponder()
        view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField==self.amount{
            textField.resignFirstResponder()
        } else if textField==self.displayOutlet{
            textField.resignFirstResponder()
        }
        else if textField==self.monthlyPayment{
            textField.resignFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interestPaid.isHidden = true
        amountPaid.isHidden = true
        monthlyPaymentLabel.isHidden = true
        amount.becomeFirstResponder()
         self.amount.delegate=self
        //monthlyPayment.becomeFirstResponder()
        self.monthlyPayment.delegate=self
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

