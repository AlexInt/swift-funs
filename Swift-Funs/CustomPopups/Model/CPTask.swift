//
//  CPTask.swift
//  Swift-Funs
//
//  Created by jimmy on 2022/1/22.
//

import Foundation

//MARK: - task model
struct CPTask: Identifiable {
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
}

// MARK: Sample Tasks
var tasks: [CPTask] = [
    CPTask(taskTitle: "Meeting", taskDescription: "Discuss team task for the day"),
    CPTask(taskTitle: "Icon set", taskDescription: "Edit icons for team task for next week"),
    CPTask(taskTitle: "Prototype", taskDescription: "Make and send prototype"),
    CPTask(taskTitle: "Check asset", taskDescription: "Start checking the assets"),
    CPTask(taskTitle: "Team party", taskDescription: "Make fun with team mates"),
    CPTask(taskTitle: "Client Meeting", taskDescription: "Explain project to clinet"),
    
    CPTask(taskTitle: "Next Project", taskDescription: "Discuss next project with team"),
    CPTask(taskTitle: "App Proposal", taskDescription: "Meet client for next App Proposal")
]
