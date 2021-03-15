//
//  EditingPage.swift
//  TestAppiOSSUII
//
//  Created by StevenChaoo on 2021/3/15.
//

import SwiftUI

struct EditingPage: View {
    
    @EnvironmentObject var UserData: ToDo
    
    @State var title: String = ""
    @State var date: Date = Date()
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Reminder")) {
                    TextField("Please input remind.", text: self.$title)
                    DatePicker(selection: self.$date, label: { Text("Due Date") })
                }
                Section {
                    Button(action: {
                        self.UserData.add(data: SingleToDo(title: self.title, date: self.date))
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
