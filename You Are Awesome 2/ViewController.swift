//
//  ViewController.swift
//  You Are Awesome 2
//
//  Created by Vincent Stephen Huang on 9/11/17.
//  Copyright © 2017 Huang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var awesomeImage: UIImageView!
    @IBOutlet weak var soundSwitch: UISwitch!
    
    var awesomePlayer = AVAudioPlayer()
    var index = -1
    var imageNumber = -1
    var soundNumber = -1
    let numberOfImages = 10
    let numberOfSounds = 5
    
    // This code executes when the view controller loads
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - My Own Functions
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer){
        //Check if we can load in the file soundName
        if let sound = NSDataAsset(name: soundName){
            //Check if sound.data is a sound file
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                //if sound.data is not a valid audio file
                print("ERROR: data in \(soundName) couldn't be played as a sound.")
            }
            
        } else {
            //If there's an error, print it out
            print("ERROR: file \(soundName) didn't load.")
        }
    }
    
    func nonRepeatingRandom(lastNumber: Int, max: Int) -> Int{
        var newIndex = -1
        
        repeat {
            newIndex = Int(arc4random_uniform(UInt32(max)))
        } while lastNumber == newIndex
        
        return newIndex
        
    }
    
    //MARK: - Actions
    @IBAction func soundSwitchPressed(_ sender: UISwitch) {
        if !soundSwitch.isOn && soundNumber != -1 {
            //Stop playing
            awesomePlayer.stop()
        }
    }
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        
        let messages = ["You are fantastic!",
                        "You are great!",
                        "You are amazing!",
                        "When the Genius Bar needs help, they call you!",
                        "You brigten my day!",
                        "You are da bomb!",
                        "I can't wait to use your app!",
                        "Fabulous? That's you!"]
        
        
        
        //Show a message
        index = nonRepeatingRandom(lastNumber: index, max: messages.count)
        messageLabel.text = messages[index]
        
        //Show an image
        awesomeImage.isHidden = false
        imageNumber = nonRepeatingRandom(lastNumber: imageNumber, max: numberOfImages)
        awesomeImage.image = UIImage(named: "image\(imageNumber)")
        
        if soundSwitch.isOn {
            //Get a random number to use in our soundName file
            soundNumber = nonRepeatingRandom(lastNumber: soundNumber, max: numberOfSounds)
            
            //Play a sound
            let soundName = "sound\(soundNumber)"
            playSound(soundName: soundName, audioPlayer: &awesomePlayer)
            
        }
        
        
        
    }
    
}

