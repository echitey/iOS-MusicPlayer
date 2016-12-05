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

    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "proprio", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
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
    }

    @IBAction func pause(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }
    }
    @IBAction func restart(_ sender: Any) {
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    @IBAction func stop(_ sender: Any) {
        audioPlayer.currentTime = 0
        audioPlayer.stop()
    }
}

