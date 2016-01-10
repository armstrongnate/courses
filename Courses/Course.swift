//
//  Course.swift
//  Courses
//
//  Created by Nate Armstrong on 1/9/16.
//  Copyright © 2016 Nate Armstrong. All rights reserved.
//

import Foundation
import Argo
import Curry

struct Course {
    let id: Int
    let name: String
    let calendar: String
    let isPublic: Bool?

    static func contentMatches(lhs: Course, rhs: Course) -> Bool {
        return lhs == rhs
    }
}

extension Course: Decodable {

    static func decode(json: JSON) -> Decoded<Course> {
        return curry(Course.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <| ["calendar", "ics"]
            <*> json <|? "is_public"
    }

}

// MARK: - Equatable

extension Course: Equatable {}

func ==(lhs: Course, rhs: Course) -> Bool {
    return lhs.id == rhs.id
}