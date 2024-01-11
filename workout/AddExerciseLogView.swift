//
//  File.swift
//  workout
//
//  Created by 國吉宏一郎 on 2023/08/25.
//

import SwiftUI
import CoreData

struct AddExerciseLogView: View{
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var exercise: Exercise
    
    @State private var date: Date = Date()
//    @State private var List: [Log] = [Log(context: viewContext)]
    
    var body: some View {
        Form {
            Section(header: Text("日付")) {
                DatePicker("日付", selection: $date)
            }
            Section(header: Text("Set")) {
                // NavigationLink(destination: ExerciseRecordView(log: Log(context: viewContext))) {
                //     Text("記録")
                // }
            }   
            Button(action: {
                let log = Log(context: viewContext)
                log.date = date
                log.exercise = exercise
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("追加")
            }
        }
    }
}
