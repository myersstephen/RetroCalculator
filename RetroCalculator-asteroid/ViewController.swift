//
//  ViewController.swift
//  RetroCalculator-asteroid
//
//  Created by stephen myers on 11/7/16.
//  Copyright © 2016 Stephen Myers. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var btnSound : AVAudioPlayer!
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var runningNumber = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType:"wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
    }
    
    
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    
    }
    
   
    @IBAction func onDividePressed(_ sender: Any) {
        processOperation(operation: .Divide)
    }
    

    @IBAction func onMultiplyPressed(_ sender: Any) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(_ sender: Any) {
        processOperation(operation: .Subtract)
    }
    
   
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(_ sender: Any) {
        processOperation(operation: currentOperation)
    }
   
    
    
    func playSound() {
        //if its already being play and this function is called again
        if btnSound.isPlaying {
            btnSound.stop()
        }
    
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        playSound()
        if currentOperation != Operation.Empty {
            //if we have pressed some button
            
            //A user selected an operator but then selected another operator without choosing a Number
            if runningNumber != "" {
                rightValStr = runningNumber
                //reassign running number to be empty
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
                
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }

    

}

