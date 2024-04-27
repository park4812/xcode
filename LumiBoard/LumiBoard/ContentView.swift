//
//  ContentView.swift
//  LumiBoard
//
//  Created by Amanda on 2/29/24.
//

import SwiftUI

struct ContentView: View {
     
    let colors: [Color] = [.red, .green, .blue, .orange, .yellow] // 원의 색상 배열
    @State private var selectedColor: Color? // 선택된 원의 색상을 저장하는 상태 변수
    @State private var selectedBackgroundColor: Color? // 선택된 원의 색상을 저장하는 상태 변수
    @State private var inputText: String = ""
    
    @State private var isLinkActive = false
    
    @State var detailView = DetailView()
    

    
    var body: some View {
        GeometryReader { geometry in
            NavigationView(){
                VStack (alignment:.leading ){
                    Text("전광판에 표시할 글자")
                        .padding()
                    TextField("여기에 입력하세요", text: $inputText)
                        .border(Color.gray)
                        .padding()
                    
                    Text("텍스트 색상 설정")
                        .padding()
                    
                    HStack(alignment:.top, spacing: 0) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .padding(5)
                                .overlay(
                                    // 선택된 원에 대한 시각적 구분
                                    Circle().stroke(selectedColor == color ? Color.black : Color.clear, lineWidth: 3)
                                        .frame(width: 30, height: 30)
                                )
                                .onTapGesture {
                                    self.selectedColor = color
                                }
                        }
                    }
                    
                    Text("배경 색상 설정")
                        .padding()
                    
                    HStack(alignment:.top, spacing: 0) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .padding(5)
                                .overlay(
                                    // 선택된 원에 대한 시각적 구분
                                    Circle().stroke(selectedBackgroundColor == color ? Color.black : Color.clear, lineWidth: 3)
                                        .frame(width: 30, height: 30)
                                )
                                .onTapGesture {
                                    self.selectedBackgroundColor = color
                                }
                        }
                        
                    }
                    
                    Button("저장") {

                        detailView = DetailView(text: inputText, foreGround: selectedColor, backGround: selectedBackgroundColor);
                        print(inputText)
                        detailView.text = inputText
                        
                        self.isLinkActive = true
                    }
                    .padding()
                    .frame(width: geometry.size.width, alignment: .center)
                    
                    
                    NavigationLink(destination: detailView, isActive: $isLinkActive) {
                       
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                
                
            }
        }
    }
}

struct DetailView: View {
    @State var text: String = ""
    @State var foreGround: Color?
    @State var backGround: Color?

    var body: some View {
        GeometryReader { geometry in
            Grid(){
                Text(text).foregroundStyle(foreGround!)
                    .font(.system(size: 30))
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .background(backGround!)
        }
    }
}

#Preview {
    ContentView()
}
