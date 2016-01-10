//
//  ViewController.swift
//  Courses
//
//  Created by Nate Armstrong on 1/6/16.
//  Copyright © 2016 Nate Armstrong. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    var viewModel: ViewModel?
    private var vm: ViewModel {
        guard let vm = viewModel else {
            fatalError("no view model!")
        }
        return vm
    }

    let tableView: UITableView = UITableView(frame: CGRectZero, style: .Plain)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.reloadData()

        bindViewModel()
        makeConstraints()
    }

    func bindViewModel() {
        vm.contentChangesSignal
            .observeOn(UIScheduler())
            .observeNext({ [weak self] changeset in
                self?.tableView.beginUpdates()
                self?.tableView.deleteRowsAtIndexPaths(changeset.deletions, withRowAnimation: .Left)
                self?.tableView.reloadRowsAtIndexPaths(changeset.modifications, withRowAnimation: .Automatic)
                self?.tableView.insertRowsAtIndexPaths(changeset.insertions, withRowAnimation: .Automatic)
                self?.tableView.endUpdates()
            })

        vm.refreshObserver.sendNext(())
    }

    func makeConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        tableView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        tableView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        tableView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        cell.textLabel!.text = vm.nameForCourseAtIndexPath(indexPath)
    }

}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return vm.numberOfSections()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfCoursesInSection(section)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?

        let identifier = "course_cell"

        cell = tableView.dequeueReusableCellWithIdentifier(identifier)

        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: identifier)
        }

        configureCell(cell!, atIndexPath: indexPath)

        return cell!
    }
    
}
