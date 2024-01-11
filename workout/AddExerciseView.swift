//
//  File.swift
//  workout
//
//  Created by 國吉宏一郎 on 2023/08/25.
//

import SwiftUI
import CoreData

struct AddExerciseView: View{
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(entity: Region.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Region.order, ascending: true)])
    private var regions: FetchedResults<Region>

    @FetchRequest(entity: Type.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Type.order, ascending: true)])
    private var types: FetchedResults<Type>

    @State private var exerciseName: String = ""
    @State private var regionState: Region?
    @State private var typeState: Type?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("種目名")) {
                    TextField("種目名", text: $exerciseName)
                }.pickerStyle(.segmented)
                Section(header: Text("部位")) {
                    Picker(selection: $regionState, label: Text("部位")) {
                        ForEach(regions) { region in
                            Text(region.name!).tag(Region?.some(region))
                        }
                    }.pickerStyle(.segmented)
                }
                Section(header: Text("タイプ")) {
                    Picker(selection: $typeState, label: Text("部位")) {
                        ForEach(types) { type in
                            Text(type.name!).tag(Type?.some(type))
                        }
                    }.pickerStyle(.segmented)
                }
                Button(action: {
                    let exercise = Exercise(context: viewContext)
                    exercise.name = exerciseName
                    exercise.region = regionState
                    exercise.type = typeState
                    exercise.order = Int16(regionState!.exercises!.count - 1)
                    print(regionState!.exercises!.count - 1)
                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("追加")
                }.disabled(exerciseName.isEmpty || regionState == nil || typeState == nil)
            }
        }
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

