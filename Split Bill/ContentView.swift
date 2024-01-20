//
//  ContentView.swift
//  Split Bill
//
//  Created by Georgii Khomaldishvili on 20.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showInfo: Bool = false

    @State var amountTextField: String = ""
    @State var people: Int = 1
    @State var tipPercentage: Int = 0
    
    var total: Double  {
        let peopleCount = Double(people + 1)
        let tipSelection = Double (tipPercentages[tipPercentage])
        
        let amount = Double(amountTextField) ?? 0
        
        let tipValue = amount / 100 * tipSelection
        
        let grandTotal = amount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson;
    }
    
    let tipPercentages: Array<Int> = [0, 5, 10, 15, 20, 25];
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Form {
                    TextField("Amount", text: $amountTextField)
                        .keyboardType(.decimalPad)
                    Picker("People", selection: $people) {
                        ForEach(1..<101) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.menu)
                    
                    HStack {
                        Text("Tips")
                        Picker("Tips", selection: $tipPercentage) {
                            ForEach(0..<tipPercentages.count) {
                                Text("\(self.tipPercentages[$0])%")
                            }
                        }.pickerStyle(.segmented)
                    }
                    
                    Section {
                        Text("Total: \(total, specifier: "%.2f")").font(.title3)
                    }
                }
            }
                .navigationTitle("Split Bill")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button() {
                        showInfo.toggle()
                    } label: {
                        Label("Info", systemImage: "info.circle")
                    }
                }
            
                .sheet(isPresented: $showInfo, content: {
                    Text("Split Bill").font(.largeTitle).fontWeight(.heavy)
                        .padding(.bottom)
                    Text("[telegram](https://t.me/khomaldi)").monospaced()
                })
        }
    }
}

#Preview {
    ContentView()
}
