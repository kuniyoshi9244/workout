//
//  ContentView.swift
//  workout
//
//  Created by 國吉宏一郎 on 2023/08/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Region.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Region.order, ascending: true)])
    private var regions: FetchedResults<Region>
    
    @FetchRequest(entity: Exercise.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.order, ascending: true)])
    private var exercises: FetchedResults<Exercise>

    var body: some View {
        NavigationView {
            List {
                ForEach(regions) { region in
                    Section(header: Text(region.name!)) {
                        ForEach(exercises.filter({ $0.region == region }) , id: \.self) { exercise in
                            NavigationLink(destination: ExerciseLogView(exercise: exercise)) {
                                Text(exercise.name!)
                            }
                        }
                        .onDelete(perform: { indexSet in deleteItems(region: region, at: indexSet)})
                        .onMove(perform: { indices, newOffset in moveExercises(region: region, indices: indices, newOffset: newOffset)})
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddExerciseView()) {
                        Image(systemName: "plus")
                    }
                }
            }.navigationTitle("筋トレ種目")
        }
    }

    private func deleteItems(region: Region, at: IndexSet) {
        // Regionのexercisesから削除
        exerciseArray(region.exercises!).forEach { exercise in
            if exercise.order > Int16(at.first!) {
                exercise.order -= 1
            }
        }
        let deleteExercise = exerciseArray(region.exercises!)[at.first!]
        print(at.first!)
        do {
            viewContext.delete(deleteExercise)
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func moveExercises(region: Region, indices: IndexSet, newOffset: Int) {
        exerciseArray(region.exercises!).forEach { exercise in
            print(exercise.name! + "：" + String(exercise.order))
        }

        if indices.first! < newOffset + 1 {
            // Regionのexercisesから削除
            exerciseArray(region.exercises!).forEach { exercise in
                if exercise.order > Int16(indices.first!)  && exercise.order < Int16(newOffset){
                    exercise.order -= 1
                }
            }
            let moveExercise = exerciseArray(region.exercises!)[indices.first!]
            moveExercise.order = Int16(newOffset - 1)
        }

        if indices.first! >= newOffset + 1 {
            // Regionのexercisesから削除
            exerciseArray(region.exercises!).forEach { exercise in
                if exercise.order >= Int16(newOffset)  && exercise.order < Int16(indices.first!){
                    exercise.order += 1
                }
            }
            let moveExercise = exerciseArray(region.exercises!)[indices.first!]
            moveExercise.order = Int16(newOffset)
        }

        print("移動元：" + String(indices.first!))
        print("移動先：" + String(newOffset))
        exerciseArray(region.exercises!).forEach { exercise in
            print(exercise.name! + "：" + String(exercise.order))
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
   /// NSSet? → [Student]変換
   private func exerciseArray(_ exercises: NSSet?) -> [Exercise] {
       let array = exercises!.allObjects as! [Exercise]
       return array.sorted(by: { $0.order < $1.order })
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
