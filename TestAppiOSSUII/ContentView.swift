//
//  ContentView.swift
//  TestAppSUI
//
//  Created by StevenChaoo on 2021/3/14.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var UserData: ToDo = ToDo(data: [
                                                SingleToDo(title: "Homework"),
                                                SingleToDo(title: "Exercise")])
//    @ObservedObject var UserData: ToDo = ToDo()
    
    @State var showEditingPage: Bool = false
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(.vertical, showsIndicators: true){
                    VStack {
                        ForEach(self.UserData.TodoList){ item in
                            SingleCardView(index: item.id)
                                .environmentObject(self.UserData)
                                .padding(.horizontal)
                                .padding(.top)
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

struct SingleCardView: View {
    
    @EnvironmentObject var UserData: ToDo
    var index: Int
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 6)
                .foregroundColor(.blue)
            VStack(alignment: .leading, spacing: 6){
                Text(self.UserData.TodoList[index].title)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Text(self.UserData.TodoList[index].date.description)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }.padding(.leading)
            Spacer()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
