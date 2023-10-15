//
//  Channel.swift
//  rss-reader
//
//  Created by atriiy on 2023/10/15.
//

import Foundation
import CoreData

final class Channel: NSManagedObject, Identifiable {
    @NSManaged var title: String
    @NSManaged var link: URL
    @NSManaged var des: String
    @NSManaged var language: String
}
