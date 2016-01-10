//
//  CourseStore.swift
//  Courses
//
//  Created by Nate Armstrong on 1/10/16.
//  Copyright © 2016 Nate Armstrong. All rights reserved.
//

import Foundation
import Moya
import ReactiveCocoa
import Argo

class CourseStore: Store {

    // Outputs
    let coursesSignal: Signal<[Course], NoError>

    private let coursesObserver: Signal<[Course], NoError>.Observer

    override init(provider: ReactiveCocoaMoyaProvider<Canvas>) {
        let (signal, observer) = Signal<[Course], NoError>.pipe()
        self.coursesSignal = signal
        self.coursesObserver = observer
        super.init(provider: provider)
    }

    func getAll() -> SignalProducer<[Course], Error> {
        // the method overload of `request` forces us to be explicit about the return type
        let signal: SignalProducer<Response, Error> = provider.request(Canvas.Courses)

        return signal
            .map { response in
                if let jsonObject: AnyObject = try? NSJSONSerialization.JSONObjectWithData(response.data, options: []) {
                    let json = JSON.parse(jsonObject)
                    switch json {
                    case .Array(let courses):
                        return courses.map { Course.decode($0).value! }
                    default:
                        print("did not get an array")
                    }
                }
                return []
            }
    }

}