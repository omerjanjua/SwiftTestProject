//
//  PostDataSource.swift
//  SwiftTestProject
//
//  Created by Omer Janjua on 16/07/2016.
//  Copyright © 2016 Janjua Ltd. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import SwiftyJSON

class PostDataSource: NSObject {
    
    func postList(success success:() -> Void, failure:() -> Void) {
        let urlString: URLStringConvertible = "http://jsonplaceholder.typicode.com/posts"
        
        Manager.sharedInstance
            .request(.GET, urlString).validate()
            .responseJSON { response in
                
                switch response.result {
                    
                case .Success:
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.deleteContext("Post")
                    
                    if let value: JSON = JSON(response.result.value!) {
                        var post: [Post] = []
                        for (_,jsonUser):(String, JSON) in value {
                            if let newPost: Post = Post.parseWithJSON(jsonUser) {
                                post.append(newPost)
                            }
                        }
                        
                        appDelegate.saveContext()
                        success()
                    }
                    
                case .Failure:
                    failure()
                }
        }
    }
    
    class func fetchPost() -> [Post]? {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Post")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let posts: [Post] = try managedContext.executeFetchRequest(fetchRequest) as! [Post]
            return posts
        } catch let error as NSError {
            print("Error : \(error) \(error.userInfo)")
        }
        return nil
    }
}
