//
//  ViewController.swift
//  TIMER
//
//  Created by Han, Jelly on 5/22/20.
//  Copyright © 2020 Han, Jelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var timelbl: UILabel!
    var countDownTime:[Int]?
    var timer: Timer?
    var remainingTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timelbl.text = String.init(format: "%02i:%02i:%02i%", 0,0,0)
        
    }
    func disableButton(btn: UIButton)
    {
        btn.isEnabled = false
        btn.backgroundColor = UIColor.systemGray
    }
    func enableButton(btn: UIButton, color: UIColor)
    {
        btn.isEnabled = true
        btn.backgroundColor = color
    }
    @IBAction func startButtonClick(_ sender: UIButton) {
        startTimerFnc()
        disableButton(btn: startBtn)
        enableButton(btn: pauseBtn, color: UIColor.systemYellow)
        
    }

    @IBAction func pauseButtonClick(_ sender: UIButton) {
        pauseTimerFnc()
        disableButton(btn: pauseBtn)
        enableButton(btn: startBtn, color: UIColor.systemGreen)
    }
    
    @IBAction func stopButtonClick(_ sender: UIButton) {
        stopTimerFnc()
        startBtn.isEnabled = true
        enableButton(btn: startBtn, color: UIColor.systemGreen)
        enableButton(btn: pauseBtn, color: UIColor.systemYellow)
    }
    // start timer
    func startTimerFnc()
    {
        // TODO: fire the timer
        guard let cdtime = countDownTime else {return}
        remainingTime = cdtime[0]*60*60 + cdtime[1]*60 + cdtime[2];

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ (timer) in
                if self.remainingTime <= 0 {
                    timer.invalidate()
                    self.timelbl.text = "Time up !"
                    self.startBtn.backgroundColor = UIColor.systemGreen
                    print(" stopTimer")
                    return
                }
                self.remainingTime -= 1
                var cur = self.remainingTime
                let hours  = Int(cur / 3600)// init timer
                cur -= hours * 3600
                let min  = Int(cur/60)
                cur -= min*60
                let sec  = Int(cur)
                DispatchQueue.main.async {
                    self.timelbl.text = String.init(format: "%02i:%02i:%02i%", hours,min,sec)
                }
        }
    }
    func pauseTimerFnc(){
         timer?.invalidate()
         print("pause timer")
        return
    }
    func stopTimerFnc() {
            timer?.invalidate()
            remainingTime = 0
            timelbl.text = "Time up !"
            print(" stopTimer")
            return
    }


    // time picker config
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component)
        {
            case 0: // first component has 24 hours
                return 24;
            case 1: // second component has 60 min
                return 60;
            case 2: // third component has 60 seconds
                return 60;
            default:
                return 60;
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)->String?{
        return "\(row)"
    }
    
    
    // use view picker scroll to select(delegation override func)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        let h = Int(pickerView.selectedRow(inComponent: 0))
        let m = Int(pickerView.selectedRow(inComponent: 1))
        let s = Int(pickerView.selectedRow(inComponent: 2))
        countDownTime = [h, m, s]
        timelbl.text = String.init(format: "%02i:%02i:%02i%", h,m,s)
               
//        print(countDownTime!)
    }


}

