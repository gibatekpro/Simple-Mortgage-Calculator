//
//  ContentView.swift
//  MortgageLabApp
//
//  Created by Philip Trwoga on 11/11/2023.
//

//indicative code only

import SwiftUI

struct ContentView: View {
    
    @AppStorage("monthlyPayment") var monthlyPayment: String = "300000"
    @AppStorage("interestRate") var interestRate: String = "4"
    @AppStorage("loanDuration") var loanDuration: String = "25"
    @AppStorage("totalAmount") var totalAmount: Double = 0.0
    
    @State var calculator = FinancialFormulae()
    
    @FocusState private var isFocused : Bool
    
    var body: some View {
        ScrollView{
            VStack {
                Spacer(
                    minLength: 150
                )
                Text("Mortgage Calculator")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .background(
                        Image("house")
                            .resizable()
                            .frame( width: 250, height: 400)
                            .opacity(0.2)
                        
                    )
                
                Label("Monthly Payment",systemImage: "sterlingsign.circle.fill" )
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                TextField(monthlyPayment, text: $monthlyPayment)
                    .keyboardType(.decimalPad)
                    .frame(width: 400, height: 55)
                    .border(Color.blue, width: 2)
                    .cornerRadius(16)
                    .frame(width: 300, height: 40)
                    .background(in: Rectangle())
                    .backgroundStyle(.white)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .focused($isFocused)
                    .onChange(of: monthlyPayment){newState in
                        monthlyPayment = checkText(text: newState)
                        
                        //Filter string to remove letters
                        filterText(newState, $monthlyPayment)
                        
                    }
                
                Spacer(minLength: 20)
                
                Label("Loan period - years",systemImage: "clock.badge.questionmark" )
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                TextField(loanDuration, text: $loanDuration)
                    .keyboardType(.decimalPad)
                    .frame(width: 400, height: 55)
                    .border(Color.blue, width: 2)
                    .cornerRadius(3)
                    .background(in: Rectangle())
                    .backgroundStyle(.white)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .focused($isFocused)
                    .onChange(of: loanDuration){newState in
                        loanDuration = checkText(text: newState)
                        
                        //Filter string to remove letters
                        filterText(newState, $loanDuration)
                        
                    }
                
                Label("Interest rate",systemImage: "percent" )
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                TextField(interestRate, text: $interestRate)
                    .keyboardType(.decimalPad)
                    .frame(width: 400, height: 55)
                    .border(Color.blue, width: 2)
                    .cornerRadius(3)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .focused($isFocused)
                    .onChange(of: interestRate){newState in
                        interestRate = checkText(text: newState)
                        
                        //Filter string to remove letters
                        filterText(newState, $interestRate)
                        
                    }

                Button(action: {
                    isFocused = false
                    totalAmount = calculator.mortgageCalculator(monthlyPayment,interestRate,loanDuration)
                }, label: {
                    Text("Calculate")
                        .foregroundColor(.blue)
                    
                }).padding()
                
                Text("Amount that can be borrowed: £\(String(format: "%.2f", totalAmount))")
                    .foregroundColor(.black)
                    .padding()
                
            }
        }.background(Color.white)

    }

    func checkText(text:String)->String{
        var updatedString = text
        var dotCount = 0
        for d in text {
            if String(d) == "."
            {  dotCount += 1  }
        }
        if dotCount >= 2 {
            // remove the last typed point
            updatedString = String(text.dropLast())
        }
        return updatedString
    }
    
    func filterText(_ newValue: String, _ binding: Binding<String>){
        //I am using this function to ensure that letters can't be an input
        let filteredString = newValue.filter({ $0.isNumber || $0.isPunctuation})
        
        if filteredString != newValue{
            binding.wrappedValue = filteredString
        }
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
