//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by jnappi on 11/4/15.
//  Copyright (c) 2015 jnappi. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    @IBOutlet weak var slowButton: UIButton!
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if var path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            var audioFile = NSURL(fileURLWithPath:path)
            
            var error:NSError?
            audioPlayer = AVAudioPlayer(contentsOfURL: audioFile, error: &error)
            audioPlayer.enableRate = true
        } else {
            println("Unable to load movie_quote.mp3")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // playAudioAtRate accepts an argument for the rate at which an instance's
    // audioPlayer will playback it's audio. The audio is then safetly played
    // back until either the clip ends or the stop button is pressed.
    func playAudioAtRate(rate: Float) {
        println("in playAudioAtRate")
        // Stop the audio. We don't want multiple audio streams playing if the 
        // user accidentally double taps a button
        audioPlayer.stop()
        
        // Set the rate that the audio will play at
        audioPlayer.rate = rate
        
        // Start playing the audio at the beginning of the stream, not where
        // it last ended it's playback
        audioPlayer.currentTime = 0.0
        
        // Prepare the audio stream, and begin playing the audio
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    // Play the audioplayer at a rate of 0.5 (half speed)
    @IBAction func playSlowAudio(sender: UIButton) {
        println("in playSlowAudio")
        playAudioAtRate(0.5)
    }
    
    // Play the audioplayer at a rate of 1.5 (1.5x speed)
    @IBAction func playFastAudio(sender: UIButton) {
        println("in playFastAudio")
        playAudioAtRate(1.5)
    }

    // Stop all audio playback and set the stream back to the beginning
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
