// Author: StevenChaoo
// <https://github.com/StevenChaoo>


import SwiftUI


/*
 Var:
    UserData:       a environment object to initialize class ToDo
    title:          to initialize title of data
    date:           to initialize date of data
    id:             to initialize id to null as default
    presentation:   basic object of setting presentation mode
 */
struct EditingPage: View {
    
    @EnvironmentObject var UserData: ToDo
    @Environment(\.presentationMode) var presentation
    
    @State var title: String = ""
    @State var date: Date = Date()
    
    var id: Int? = nil
    
    // To show a navigation view of a new page which consists of two sections
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Reminder")) {
                    TextField("Please input remind.", text: self.$title)
                    DatePicker(selection: self.$date, label: { Text("Due Date") })
                }
                
                Section {
                    Button(action: {
                        if self.id == nil {
                            self.UserData.add(data: SingleToDo(title: self.title, date: self.date))
                        }
                        else {
                            self.UserData.edit(id: id!, data: SingleToDo(title: self.title, date: self.date))
                        }
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("Confirm")
                    })
                    
                    Button(action: {self.presentation.wrappedValue.dismiss()}, label: {
                        Text("Cancel")
                    })
                }
            }
            .navigationBarTitle(Text("Append"))
        }
    }
}


struct EditingPage_Previews: PreviewProvider {
    static var previews: some View {
        EditingPage()
    }
}
