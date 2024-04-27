//
//  ContentView.swift
//  calculator
//
//  Created by Amanda on 3/9/24.
//

import SwiftUI


extension Color {
    static let customGray = Color(red: 56 / 255, green: 56 / 255, blue: 56 / 255)
    static let customLightGray = Color(red: 176 / 255, green: 176 / 255, blue: 176 / 255)
    static let customYellow = Color(red: 231 / 255, green: 177 / 255, blue: 72 / 255)
}


struct ContentView: View {

    @State private var numberValue: String = "0"
    private var formattedNumber: String {
        formatNumber(numberValue)
    }
    @State var value: String = "0"
    let size: CGFloat = 80
    let fontSize: CGFloat = 35
    
    
    func putNumber(num:String)
    {
        let temp = numberValue + num
        
        if numberValue.hasSuffix(".")
        {
            numberValue = temp
            return
        }
        else if(temp.count > 9)
        {
            return
        }
        
        if(num == "." && Int(numberValue) != nil && numberValue == "0"){
            numberValue = numberValue + num
        }
        else
        {
            let valueInt = Int(temp)
            let valueFloat = Float(temp)
            
            if(valueInt != nil)
            {
                numberValue = String(Int(temp)!)
            }else if(valueFloat != nil)
            {
                numberValue = temp
            }
            else{
                
            }
        }
    }
    
    // 문자열 길이에 따라 폰트 크기를 결정하는 함수
    private func fontSize(for text: String) -> CGFloat {
        let length = text.count
        switch length {
            case 0..<6:
                return 85
            case 6..<7:
                return 78
            case 7..<8:
                return 70
            case 8..<9:
                return 62
            case 9..<10:
                return 55
            default:
                return 55
        }
    }
    
    func formatNumber(_ numberString: String) -> String {
        // Double 변환을 시도합니다.
        guard let number = Double(numberString), !numberString.isEmpty else { return numberString }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 천 단위 구분 쉼표를 추가합니다.
        formatter.minimumFractionDigits = 0 // 소수점 이하 최소 자릿수를 0으로 설정합니다.
        formatter.maximumFractionDigits = 16 // 소수점 이하 최대 자릿수를 설정합니다.

        let formattedString = formatter.string(from: NSNumber(value: number)) ?? ""

        // 숫자의 소수점 이하 부분이 "0" 또는 없는 경우, 정수 부분만 반환합니다.
        // 숫자 문자열이 "."으로 끝나면, 포맷된 문자열에 "."을 추가합니다.
        if numberString.hasSuffix(".") {
            return formattedString + "."
        } else {
            if formattedString == "0"
            {
                return numberString
            }else
            {
                return formattedString
            }
        }
    }


    
    var body: some View {
        
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Grid{
                    Spacer()
                        .frame(height: 50)
                    GridRow{
                        TextField("0",text: .constant(formattedNumber))
                            .foregroundColor(.white)
                            .font(.system(size: fontSize(for: numberValue)))                     .multilineTextAlignment(.trailing)
                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            .padding()
                    }
                }.frame(height: geometry.size.height * 0.2)
                
                Grid {
                    GridRow {
                        Button(action: {
                            print("ac")
                            numberValue = "0"
                        }){
                            Capsule()
                                .fill(Color.customLightGray)
                                .frame(width: 260, height: size)
                                .overlay { Text("AC").foregroundColor(.black).font(.system(size: fontSize)) }
                        }.gridCellColumns(3)

                        Button(action: {
                            print("÷")
                        }){
                            Circle()
                                .fill(Color.customYellow)
                                .frame(width: size, height: size)
                                .overlay { Text("÷").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                    }
                    
                    
                    GridRow {
                        Button(action: {
                            print("7")
                            putNumber(num: "7")
                        }){
                            Circle()
                                .fill(Color(Color.customGray))
                                .frame(width: size, height: size)
                                .overlay { Text("7").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                        
                        Button(action: {
                            print("8")
                            putNumber(num: "8")
                        }){
                            Circle()
                                .fill(Color(Color.customGray))
                                .frame(width: size, height: size)
                                .overlay { Text("8").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                        
                        
                        Button(action: {
                            print("9")
                            putNumber(num: "9")
                        }){
                            Circle()
                                .fill(Color(Color.customGray))
                                .frame(width: size, height: size)
                                .overlay { Text("9").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                        
                        
                        Button(action: {
                            print("x")
                        }){
                            Circle()
                                .fill(Color.customYellow)
                                .frame(width: size, height: size)
                                .overlay { Text("x").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                        
                    }
                    
                    GridRow {
                        Button(action: {
                            print("4")
                            putNumber(num: "4")
                        }){
                            Circle()
                                .fill(Color(Color.customGray))
                                .frame(width: size, height: size)
                                .overlay { Text("4").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                        
                        Button(action: {
                            print("5")
                            putNumber(num: "5")
                        }){
                            Circle()
                                .fill(Color(Color.customGray))
                                .frame(width: size, height: size)
                                .overlay { Text("5").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                        
                        
                        Button(action: {
                            print("6")
                            putNumber(num: "6")
                        }){
                            Circle()
                                .fill(Color(Color.customGray))
                                .frame(width: size, height: size)
                                .overlay { Text("6").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                        
                        
                        Button(action: {
                            print("-")
                        }){
                            Circle()
                                .fill(Color.customYellow)
                                .frame(width: size, height: size)
                                .overlay { Text("-").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                    }
                    
                    GridRow {
                        Button(action: {
                            print("1")
                            putNumber(num: "1")
                        }){
                            Circle()
                                .fill(Color(Color.customGray))
                                .frame(width: size, height: size)
                                .overlay { Text("1").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                        
                        Button(action: {
                            print("2")
                            putNumber(num: "2")
                        }){
                            Circle()
                                .fill(Color(Color.customGray))
                                .frame(width: size, height: size)
                                .overlay { Text("2").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                        
                        
                        Button(action: {
                            print("3")
                            putNumber(num: "3")
                        }){
                            Circle()
                                .fill(Color(Color.customGray))
                                .frame(width: size, height: size)
                                .overlay { Text("3").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                        
                        
                        Button(action: {
                            print("+")
                        }){
                            Circle()
                                .fill(Color.customYellow)
                                .frame(width: size, height: size)
                                .overlay { Text("+").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                    }
                    
                    GridRow {
                        Button(action: {
                            print("0")
                            putNumber(num: "0")
                        }){
                            Capsule()
                                .fill(Color(Color.customGray))
                                .frame(width: 170, height: size)
                                .overlay { Text("0").foregroundColor(.white).font(.system(size: fontSize)) }
                        }.gridCellColumns(2)
                        
                        Button(action: {
                            print(".")
                            putNumber(num: ".")
                        }){
                            Circle()
                                .fill(Color(Color.customGray))
                                .frame(width: size, height: size)
                                .overlay { Text(".").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                        
                        
                        Button(action: {
                            print("=")
                        }){
                            Circle()
                                .fill(Color.customYellow)
                                .frame(width: size, height: size)
                                .overlay { Text("=").foregroundColor(.white).font(.system(size: fontSize)) }
                        }
                    }
                }
                .frame(height: geometry.size.height * 0.6)
                
                Color.black
                    .frame(height: geometry.size.height * 0.2)
            }
            .frame(width: geometry.size.width)
            .background(.black)
        }
    }
}

#Preview {
    ContentView()
}
