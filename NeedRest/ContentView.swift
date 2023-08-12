import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Date.now
    @State private var cofeeAnmmount = 1
    @State private var sleepAmmount = 8.0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
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
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try RestData(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hours = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hours + minutes), coffee: Double(cofeeAnmmount), actualSleep: sleepAmmount)
            
            let sleepTime = wakeUpTime - prediction.estimatedSleep
            alertTitle = "Your ideal sleep time is:"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }
        catch {
            alertTitle = "Error"
            alertMessage = "Something went wrong"
        }
        
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
