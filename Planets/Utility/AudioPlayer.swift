//
//  AudioPlayer.swift
//  Planets
//
//  Created by Furkan Ceylan on 12.08.2024.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func audioPlayer(sound: String, extention: String){
    if let path = Bundle.main.path(forResource: sound, ofType: extention) {
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            guard let audioPlayer = audioPlayer else {return}
            audioPlayer.play()
        }catch{
            print(error.localizedDescription)
        }
    }
}
