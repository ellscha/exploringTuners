//
//  ViewController.swift
//  musicDabble
//
//  Created by Rebecca Bartels on 7/11/16.
//  Copyright © 2016 Rebecca Bartels. All rights reserved.
//
import UIKit
import TuningFork
import AudioKit
import Pitchy




class ViewController: UIViewController, TunerDelegate{
    
    // I had to have the tunerDelegate in my file.
    
    var tuner: Tuner?
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var noteSlider: UISlider!
    var tunerOn = false //bool here. When you start application the tuner is off, so it is false.
    
    @IBOutlet weak var noteButtonLabel: UIButton!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        noteButtonLabel.titleLabel?.font = UIFont(name: "CourierNewPS-ItalicMT", size: 30)
        //I have to unwrap the noteButtonLabel because....titleLabel is an optional property. ! unwraps it and ? works also because it is an optional.
        
        frequencyLabel.textColor = UIColor.cloudsColor()
        noteButtonLabel.setTitleColor(UIColor.cloudsColor(), forState: .Normal)
        
        
        frequencyLabel.font = UIFont.boldSystemFontOfSize(39.0)
        
        
        //variable above tuner is equal to new initialized tuner
        tuner = Tuner ()
        tuner?.delegate = self
        //sets Tunerdelegate equal to that tuner
    }
    
    
    func tunerDidUpdate(tuner: Tuner, output: TunerOutput){
        // tuner is of type tuner and output is of type tuner output, they are both part of the tuner framework TuningFork. 
       print(output.pitch, output.octave)
        
        //octave is an int. Opt. Click shows that. String(output.octave) turns it into a string.
        //updating every 300th of a second - NSTimer says so that lives in a file in this massive project.
        
        //only registers a note if it is above the amplitude threshold of 0.1
        if (output.amplitude > 0.2) {
            noteSlider.value = output.frequency
            frequencyLabel.text = output.pitch + String(output.octave)
            frequencyLabel.font = UIFont (name: "CourierNewPS-ItalicMT", size: 30)
       
        }
        
}
  
    @IBAction func noteButton(sender: AnyObject) {
        
        //toggle on/off 
        
        if tunerOn {
            tuner!.stop()     //if tuner is on, we want to stop it, change the bool to false, and change the label to start.
            tunerOn = false
            noteButtonLabel.setTitle("Start", forState: .Normal)
            
        } else {
            
            tuner!.start()
            tunerOn = true
            noteButtonLabel.setTitle("Stop", forState: .Normal)  //opposite from top
        }
   
        //tuner start now. start is a built in method that has NSTimer loop.
        }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
