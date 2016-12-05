//
//  ViewController.swift
//  Music Player
//
//  Created by Yawo Echitey on 12/5/16.
//  Copyright © 2016 Echitey. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var Slider: UISlider!

    var audioPlayer = AVAudioPlayer()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "proprio", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
            Slider.maximumValue = Float(audioPlayer.duration)
            
            let session = AVAudioSession.sharedInstance()
            
            do{
                try session.setCategory(AVAudioSessionCategoryPlayback)
            }catch{
                print(error)
            }
            
        }catch{
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(_ sender: Any) {
        audioPlayer.play()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateSlider), userInfo: nil, repeats: true)
        
    }

    @IBAction func pause(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            timer.invalidate()
        }
    }
    @IBAction func restart(_ sender: Any) {
        timer.invalidate()
        audioPlayer.currentTime = 0
        Slider.value = 0
        audioPlayer.play()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateSlider), userInfo: nil, repeats: true)
    }
    @IBAction func stop(_ sender: Any) {
        audioPlayer.currentTime = 0
        audioPlayer.stop()
        Slider.value = 0
        timer.invalidate()
    }
    
    @IBAction func sliderChange(_ sender: Any) {
        audioPlayer.currentTime = TimeInterval(Slider.value)
    }
    
    func updateSlider(){
        Slider.value = Float(audioPlayer.currentTime)
    }
    
}

