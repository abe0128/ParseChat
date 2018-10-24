//
//  Message.swift
//  ParseChat
//
//  Created by Abraham De Alba on 10/23/18.
//  Copyright © 2018 Abraham De Alba. All rights reserved.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing
{
    @NSManaged var message: String
    
    class func parseClassName() -> String
    {
        return "Message"
    }
}
