import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Date.now
    @State private var cofeeAnmmount = 1
    @State private var sleepAmmount = 8.0
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Please enter time", selection: $wakeUpTime, displayedComponents: .hourAndMinute )
                    .labelsHidden()
                
                Text("Desired amount of sleep")
                    .font(.headline)
                
                Stepper("\(sleepAmmount.formatted()) hours", value: $sleepAmmount, in: 4...12, step: 0.25)
                
                Text("Daily coffee intake")
                    .font(.headline)
                
                Stepper(
                    cofeeAnmmount == 1 ? "1 cup" : "\(cofeeAnmmount) cups",
                    value: $cofeeAnmmount,
                    in: 1...8
                )
            }
            .navigationTitle("Better rest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
        }
    }
    
    private func calculateBedtime() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
