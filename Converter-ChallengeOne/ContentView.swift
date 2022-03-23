//
//  ContentView.swift
//  Converter-ChallengeOne
//
//  Created by Cengizhan Er on 22.03.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var typeConverted : [String] = ["m","km","ft","yrd","mil"]
    @State private var typeToIn : String = "m"
    @State private var typeToReturn : String = "km"
    @State private var valueOfInput : Double = 0.0
    @State private var valueOfReturn : Double = 0.0
    @FocusState private var isFocused : Bool
    
    func convert(value : Int ,from : String, to : String){
        var centimetreValue: Double=0.0
        
        if(from=="m"){
            centimetreValue = Double(value*100)
        }else if(from=="km"){
            centimetreValue = Double(value*1000)
        }else if(from=="ft"){
            centimetreValue=Double(Double(value)*30.48)
        }else if(from=="yrd"){
            centimetreValue=Double(Double(value)*91.44)
        }else if(from=="mil"){
            centimetreValue=Double(value*160934)
        }
        
        if(to=="m"){
            valueOfReturn = (centimetreValue/100)
        }else if(to=="km"){
            valueOfReturn = (centimetreValue/1000)
        }else if(to=="ft"){
            valueOfReturn = (Double(centimetreValue)/30.48)
        }else if(to=="yrd"){
            valueOfReturn = (Double(centimetreValue)/91.44)
        }else if(to=="mil"){
            valueOfReturn = (Double(centimetreValue/160934))
        }
        
       
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Enter a value",value: $valueOfInput,formatter:NumberFormatter())
                        .background()
                        .opacity(0.3)
                        .cornerRadius(50)
                        .font(.headline)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }
                Section{
                    // Text(typeToIn)
                    // .foregroundColor(Color.blue)
                    Picker("Hangi birimden veri girilecek?",
                           selection: $typeToIn ,
                           content:{
                        ForEach(typeConverted,id: \.self){ type in
                            
                            Text(type).tag(type)
                            
                        }
                    }
                    )
                    .pickerStyle(.menu)
                    
                }//Second Section
                
            header:{
                Text("Choose the input type")
            }
                Section{
                    
                    
                    Picker("Hangi birime dönülecek?", selection: $typeToReturn) {
                        
                        ForEach (typeConverted,id: \.self){ typeTo in
                            Text(typeTo).tag(typeTo)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    
                }
            header:{
                Text("Choose to output type")
            }
                Section{
                    
                    Text(valueOfReturn,format: .number)
                }
            header:
                {
                    Text("Result ")
                }
            }
            .navigationTitle("Converter")
            .toolbar{
                
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        isFocused=false
                        convert(value: Int(valueOfInput), from: typeToIn, to: typeToReturn)
                    }
                }
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
