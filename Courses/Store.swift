//
//  Store.swift
//  Courses
//
//  Created by Nate Armstrong on 1/10/16.
//  Copyright © 2016 Nate Armstrong. All rights reserved.
//

import Foundation
import Moya

class Store {

    internal let provider: ReactiveCocoaMoyaProvider<Canvas>

    init(provider: ReactiveCocoaMoyaProvider<Canvas>) {
        self.provider = provider
    }

}
