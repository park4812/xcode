//
//  ContentView.swift
//  ToDoList
//
//  Created by Amanda on 3/23/24.
//

import SwiftUI

struct Todo: Identifiable, Decodable {
    var id: Int
    var task: String
    var status : String
}

struct ContentView: View {
    @State private var todos = [Todo]() // Todo 목록을 저장할 상태 변수
    @State private var showingPopup = false
    @State private var newTaskText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(todos) { todo in
                    Text(todo.task)
                }
                .onDelete(perform: deleteTodo)
            }
            //.navigationTitle("Todos")
            .onAppear {
                loadData()
            }
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: { self.showingPopup = true }) {
                    Image(systemName: "plus")
                }
            )
        }
        .blur(radius: showingPopup ? 20 : 0)

         if showingPopup {
             popupView
         }
        
    }
    
    
    var popupView: some View {
           VStack(spacing: 20) {
               Text("새 할 일 추가")
                   .font(.headline)

               TextField("할 일을 입력하세요", text: $newTaskText)
                   .textFieldStyle(RoundedBorderTextFieldStyle())

               HStack {
                   Button("취소") {
                       self.showingPopup = false
                       self.newTaskText = ""
                   }
                   
                   Button("추가") {
                       self.addNewTask()
                       self.showingPopup = false
                       self.newTaskText = ""
                   }
               }
           }
           .padding()
           .background(Color.white)
           .cornerRadius(15)
           .shadow(radius: 10)
           .frame(width: 300)
           .transition(.scale)
       }

    func addNewTask() {
        let newTodo = Todo(id: todos.count + 1, task: newTaskText, status: "진행 중")
        todos.append(newTodo)
    }
    
    private var addButton: some View {
        Button(action: addTodo) {
            Image(systemName: "plus")
        }
    }
    
    private func addTodo() {
        // 새 Todo 항목 추가 로직
        let newId = (todos.last?.id ?? 0) + 1
        todos.append(Todo(id: newId, task: "새 할 일 \(newId)", status: "진행 중"))
    }
    
    func deleteTodo(at offsets: IndexSet) {
        
        let todo1 = getTodoAtIndex(offsets.first!)
        
        deleteTodo(todoId: todo1!.id)
        
        todos.remove(atOffsets: offsets)
    }
    
    
    func loadData() {
        guard let url = URL(string: "http://localhost:8080/api/list") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Todo].self, from: data) {
                    DispatchQueue.main.async {
                        self.todos = decodedResponse
                    }
                }
            }
        }.resume()
    }
    
    func deleteTodo(todoId: Int) {
        guard let url = URL(string: "http://localhost:8080/api/delete/\(todoId)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print("Todo successfully deleted")
            } else {
                print("Failed to delete Todo")
            }
        }

        task.resume()
    }
    
    func getTodoAtIndex(_ index: Int) -> Todo? {
        guard todos.indices.contains(index) else { return nil }
        return todos[index]
    }
}


#Preview {
    ContentView()
}
