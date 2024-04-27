//
//  ContentView.swift
//  AutoLayoutExample
//
//  Created by Amanda on 2/27/24.
//

import SwiftUI

struct Quote : Identifiable
{
    let id = UUID()
    var text: String
    var author: String
}

class QuotesViewModel: ObservableObject {
    @Published var quotes: [Quote] = []
    
    @Published var quote : Quote
    
    func addQuote(quote: Quote) {
        quotes.append(quote)
    }
    
    init() {
        
        self.quote = Quote(text: "명언", author: "이름")
        
        let initialQuotes = [
            Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
            Quote(text: "It does not matter how slowly you go as long as you do not stop.", author: "Confucius"),
            Quote(text: "Life is what happens when you're busy making other plans.", author: "John Lennon"),
            Quote(text: "The greatest glory in living lies not in never falling, but in rising every time we fall.", author: "Nelson Mandela"),
            Quote(text: "The way to get started is to quit talking and begin doing.", author: "Walt Disney"),
            Quote(text: "Your time is limited, don't waste it living someone else's life.", author: "Steve Jobs"),
            Quote(text: "If life were predictable it would cease to be life, and be without flavor.", author: "Eleanor Roosevelt"),
            Quote(text: "If you set your goals ridiculously high and it's a failure, you will fail above everyone else's success.", author: "James Cameron"),
            Quote(text: "Life is what happens when you're busy making other plans.", author: "John Lennon"),
            Quote(text: "When you reach the end of your rope, tie a knot in it and hang on.", author: "Franklin D. Roosevelt"),
            Quote(text: "Always remember that you are absolutely unique. Just like everyone else.", author: "Margaret Mead"),
            Quote(text: "Don't judge each day by the harvest you reap but by the seeds that you plant.", author: "Robert Louis Stevenson"),
            Quote(text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt"),
            Quote(text: "Tell me and I forget. Teach me and I remember. Involve me and I learn.", author: "Benjamin Franklin"),
            Quote(text: "The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.", author: "Helen Keller"),
            Quote(text: "It is during our darkest moments that we must focus to see the light.", author: "Aristotle")
        ]
        quotes.append(contentsOf: initialQuotes)
    }
}

struct ContentView: View {
    @StateObject private var viewModel = QuotesViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack() {
                Text("명언 생성기")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack() {
                    Spacer().frame(height: 30)
                    Text(viewModel.quote.text)
                        .font(.title)
                        .fontWeight(.heavy)
                        .frame(width: geometry.size.width * 0.85)
                    Spacer()
                    Text(viewModel.quote.author)
                    Spacer().frame(height: 30)
                }
                .frame(width: geometry.size.width * 0.95, height: geometry.size.height  * 0.4)
                .background(Color.gray.opacity(0.3))
                
                Spacer()
                
                Button(action:
                {
                    viewModel.quote = viewModel.quotes.randomElement()!
                },
                label:
                {
                    Text("명언 생성")
                        .font(.title)
                        .fontWeight(.bold)
                })
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    ContentView()
}
