// Author: StevenChaoo
// <https://github.com/StevenChaoo>


import SwiftUI


/*
 Initialize the user data from stored data
 
 Param:
    output: to initialize output as a empty list
 Return:
    output: contains stored data
 */
func initUserData() -> [SingleToDo] {
    
    var output: [SingleToDo] = []
    
    // To put stored data to output list from system
    if let dataStored = UserDefaults.standard.object(forKey: "TodoList") as? Data {
        let data = try! decoder.decode([SingleToDo].self, from: dataStored)
        for item in data {
            if !item.deleted {
                output.append(SingleToDo(title: item.title, date: item.date, isCheck: item.isCheck, id: output.count))
            }
        }
    }
    
    return output
}


/*
 Var:
    UserData:           initialize class ToDo named UserData
    showEidtingPage:    if app should turn on the editing page
    index:              the index of data in UserData.TodoList
 */
struct SingleCardView: View {
    
    @EnvironmentObject var UserData: ToDo
    
    @State var showEditingPage: Bool = false
    
    var index: Int
    
    // To show single page of reminder
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 6)
                .foregroundColor(.blue)
            
            Button(action: {self.UserData.delete(id: self.index)}, label: {
                Image(systemName: "trash")
                    .imageScale(.large)
                    .padding(.leading)
            })
            
            Button(action: {self.showEditingPage = true}, label: {
                Group {
                    VStack(alignment: .leading, spacing: 6){
                        Text(self.UserData.TodoList[index].title)
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        Text(self.UserData.TodoList[index].date.description)
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
            })
            .sheet(isPresented: self.$showEditingPage, content: {
                EditingPage(title: self.UserData.TodoList[index].title,
                            date: self.UserData.TodoList[index].date,
                             id: self.index)
                    .environmentObject(self.UserData)
            })
            
            Image(systemName: self.UserData.TodoList[index].isCheck ? "checkmark.square.fill":"square")
                .imageScale(.large)
                .padding(.trailing)
                .onTapGesture {
                    self.UserData.check(id: self.index)
                }
        }
        .frame(height: 80, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10, x: 0, y: 10)
    }
}


/*
 Var:
    UserData:           initialize class ToDo named UserData from function initUserData()
    showEditingPage:    if app should turn on the editing page
 */
struct ContentView: View {
    
    @ObservedObject var UserData: ToDo = ToDo(data:initUserData())
    
    @State var showEditingPage: Bool = false
    
    // To show main page if reminder app
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(.vertical, showsIndicators: true){
                    VStack {
                        ForEach(self.UserData.TodoList){ item in
                            if !item.deleted {
                                SingleCardView(index: item.id)
                                    .environmentObject(self.UserData)
                                    .padding(.horizontal)
                                    .padding(.top)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Reminder"))
            }
            
            HStack {
                VStack {
                    Spacer()
                    
                    Button(action: {self.showEditingPage = true} , label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45)
                            .foregroundColor(.black)
                            .padding(.leading)
                    })
                    .sheet(isPresented: self.$showEditingPage, content: {
                        EditingPage()
                            .environmentObject(self.UserData)
                    })
                }
                
                Spacer()
                
            }
                
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
