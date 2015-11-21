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
    var audioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Before playing any audio, we need to ensure that ALL audio has been 
    // stopped, otherwise we'll have overlapping audio playing.
    func stopAllAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
    }
    
    // playAudioAtRate accepts an argument for the rate at which an instance's
    // audioPlayer will playback it's audio. The audio is then safetly played
    // back until either the clip ends or the stop button is pressed.
    func playAudioAtRate(rate: Float) {
        print("in playAudioAtRate")
        // Stop the audio. We don't want multiple audio streams playing if the
        // user accidentally double taps a button
        stopAllAudio()
        
        // Set the rate that the audio will play at
        audioPlayer.rate = rate
        
        // Start playing the audio at the beginning of the stream, not where
        // it last ended it's playback
        audioPlayer.currentTime = 0.0
        
        // Prepare the audio stream, and begin playing the audio
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    // Modify the player for our view's audio file to play with a pitch adjusted
    // to the value of *pitch*
    func playAudioWithVariablePitch(pitch: Float){
        // Stop the audio. We don't want multiple audio streams playing if the
        // user accidentally double taps a button
        stopAllAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    // Play the audioplayer at a rate of 0.5 (half speed)
    @IBAction func playSlowAudio(sender: UIButton) {
        print("in playSlowAudio")
        playAudioAtRate(0.5)
    }
    
    // Play the audioplayer at a rate of 1.5 (1.5x speed)
    @IBAction func playFastAudio(sender: UIButton) {
        print("in playFastAudio")
        playAudioAtRate(1.5)
    }
    
    // Play our recorded audio with a modified pitch of 1000 (10+ semitones)
    @IBAction func playChipmunkAudio(sender: UIButton) {
        print("in playChipmunkAudio")
        playAudioWithVariablePitch(1000)
    }
    
    // Play our recorded audio with a modified pitch of -1000 (10- semitones)
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        print("in playDarthVaderAudio")
        playAudioWithVariablePitch(-1000)
    }
    
    // Stop all audio playback and set the audioPlayer stream back to time 0.0
    @IBAction func stopAudio(sender: UIButton) {
        stopAllAudio()
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
