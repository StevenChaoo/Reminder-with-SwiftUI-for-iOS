// Author: StevenChaoo
// <https://github.com/StevenChaoo>


import Foundation


struct SingleToDo: Identifiable, Codable {
    var title: String = ""
    var date: Date = Date()
    var isCheck: Bool = false
    var deleted: Bool = false
    var id: Int = 0
}


// Encode datas as binary datas to store in database and decode them when readed
var encoder = JSONEncoder()
var decoder = JSONDecoder()


/*
 Var:
    TodoList:   a SingleToDo type list to store SingleToDo structure
    count:      a int type varible to store numbers of SingleToDo in TodoList
 */
class ToDo: ObservableObject {
    
    @Published var TodoList: [SingleToDo]
    
    var count: Int = 0
    
    // Initialize class ToDo
    init(){
        self.TodoList = []
    }
    
    // Initialize class ToDo while getting input
    init(data: [SingleToDo]){
        self.TodoList = []
        for item in data{
            self.TodoList.append(SingleToDo(title: item.title, date: item.date, isCheck: item.isCheck, id: self.count))
            self.count += 1
        }
    }
    
    
    /*
     Toggle isCheck while clicking the button
     
     Param:
        id: point which SingleToDo should be modified
     */
    func check(id:Int) {
        self.TodoList[id].isCheck.toggle()
        self.dataStore()
    }
    
    
    /*
     Add a new data
     
     Param:
        data: a SingleToDo structure
     */
    func add(data: SingleToDo) {
        self.TodoList.append(SingleToDo(title: data.title, date: data.date, id: self.count))
        self.count += 1
        self.sort()
        self.dataStore()
    }
    
    
    /*
     Modify data
     
     Param:
        id:     which data should be modified
        data:   a SingleToDo structure
     */
    func edit(id: Int, data: SingleToDo){
        self.TodoList[id].title = data.title
        self.TodoList[id].date = data.date
        self.TodoList[id].isCheck = false
        self.sort()
        self.dataStore()
    }
    
    
    /*
     Sort datas as date and time
     */
    func sort() {
        self.TodoList.sort(by: {(data1, data2) in
            return data1.date.timeIntervalSince1970 < data2.date.timeIntervalSince1970
        })
        for i in 0..<self.TodoList.count {
            self.TodoList[i].id = i
        }
    }
    
    
    /*
     Delete a data
     
     Param:
        id: which data should be deleted
     */
    func delete(id:Int) {
        self.TodoList[id].deleted = true
        self.sort()
        self.dataStore()
    }
    
    
    /*
     Save datas in system
     */
    func dataStore() {
        let dataStored = try! encoder.encode(self.TodoList)
        UserDefaults.standard.set(dataStored, forKey: "TodoList")
    }
}
