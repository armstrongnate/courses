//
//  ViewModel.swift
//  Courses
//
//  Created by Nate Armstrong on 1/10/16.
//  Copyright © 2016 Nate Armstrong. All rights reserved.
//

import Foundation
import ReactiveCocoa

class ViewModel {

    typealias CourseChangeset = Changeset<Course>

    // Inputs
    let refreshObserver: Signal<Void, NoError>.Observer

    // Outputs
    let contentChangesSignal: Signal<CourseChangeset, NoError>

    private let store: CourseStore
    private var courses: [Course]
    private let contentChangesObserver: Signal<CourseChangeset, NoError>.Observer

    init(store: CourseStore) {
        self.store = store
        self.courses = []

        let (refreshSignal, refreshObserver) = SignalProducer<Void, NoError>.buffer()
        self.refreshObserver = refreshObserver

        let (contentChangesSignal, contentChangesObserver) = Signal<CourseChangeset, NoError>.pipe()
        self.contentChangesSignal = contentChangesSignal
        self.contentChangesObserver = contentChangesObserver

        refreshSignal
            .flatMap(.Latest) { _ in
                return store.getAll()
                    .flatMapError { error in
                        return SignalProducer(value: [])
                    }
            }
            .combinePrevious([])
            .startWithNext { [weak self] (oldResults, newResults) in
                self?.courses = newResults
                if let observer = self?.contentChangesObserver {
                    let changeset = Changeset(
                        oldItems: oldResults,
                        newItems: newResults,
                        contentMatches: Course.contentMatches
                    )
                    observer.sendNext(changeset)
                }
            }
    }

    // MARK: Data Source

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfCoursesInSection(section: Int) -> Int {
        return courses.count
    }

    func nameForCourseAtIndexPath(indexPath: NSIndexPath) -> String {
        return courses[indexPath.row].name
    }

}
