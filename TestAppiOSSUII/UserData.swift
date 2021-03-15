//
//  UserData.swift
//  TestAppiOSSUII
//
//  Created by StevenChaoo on 2021/3/14.
//

import Foundation

class ToDo: ObservableObject {
    @Published var TodoList: [SingleToDo]
    var count: Int = 0
    
    init(){
        self.TodoList = []
    }
    init(data: [SingleToDo]){
        self.TodoList = []
        for item in data{
            self.TodoList.append(SingleToDo(title: item.title, date: item.date, isCheck: false, id: self.count))
            self.count += 1
        }
    }
    
    func check(id:Int) {
        self.TodoList[id].isCheck.toggle()
    }
    
    func add(data: SingleToDo) {
        self.TodoList.append(SingleToDo(title: data.title, date: data.date, id: self.count))
        self.count += 1
    }
}

struct SingleToDo: Identifiable {
    var title: String = ""
    var date: Date = Date()
    var isCheck: Bool = false
    
    var id: Int = 0
}
