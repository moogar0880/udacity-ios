//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jon Nappi on 11/14/15.
//  Copyright © 2015 jnappi. All rights reserved.
//

import Foundation

// The RecordedAudio class is used to encapsulate recorded audio data in order
// to facilitate passing said data between views
class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    // init is the constructor for the RecordedAudio type
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
