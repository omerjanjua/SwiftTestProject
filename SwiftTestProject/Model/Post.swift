//
//  Post.swift
//  SwiftTestProject
//
//  Created by Omer Janjua on 16/07/2016.
//  Copyright © 2016 Janjua Ltd. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON


class Post: NSManagedObject {
    
    class func parseWithJSON(json: JSON) -> Post? {
        
        guard json != JSON.null || json.type != .Null else {
            return nil
        }
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext
        let entity: NSEntityDescription = NSEntityDescription.entityForName("Post", inManagedObjectContext: managedContext)!
        let post: Post = Post(entity: entity, insertIntoManagedObjectContext: managedContext)
        
        // All fields are required, as described in the Core Data model
        guard let
            id = json["id"].number,
            title = json["title"].string,
            body = json["body"].string else {
                return nil
        }
        
        post.id = id
        post.title = title
        post.body = body
        
        return post
    }
}
