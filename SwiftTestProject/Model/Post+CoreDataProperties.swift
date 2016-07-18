//
//  Post+CoreDataProperties.swift
//  SwiftTestProject
//
//  Created by Omer Janjua on 16/07/2016.
//  Copyright © 2016 Janjua Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Post {

    @NSManaged var body: String?
    @NSManaged var id: NSNumber?
    @NSManaged var title: String?

}
