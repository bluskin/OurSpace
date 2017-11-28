//
//  roommate.swift
//  ourSpace1.2
//
//  Created by Nathan Gartlan on 11/27/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import UIKit


class roommateWheel{
    var roomArray = [String]()
    init(){
        roomArray = []
    }
    func nextRoomMate(a: String) -> String {
        let currentIndex = roomArray.index(of: a)
        //if the string is located at the final element of roomArray
        if(currentIndex == (roomArray.count-1)){
            return roomArray[0]
        }
        return roomArray[currentIndex!+1]
    }
    
    func currentRoomMate(index: Int) -> String{
        return roomArray[index]
    }
    func append(newRoom: String){
        roomArray.append(newRoom)
    }
    
    func initialize(allRoomMate: [String]){
        roomArray = allRoomMate
    }
}
