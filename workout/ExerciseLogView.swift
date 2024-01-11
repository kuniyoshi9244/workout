import SwiftUI
import CoreData

struct ExerciseLogView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var exercise: Exercise
    
    @FetchRequest(entity: Log.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Log.date, ascending: false)])
    private var logs: FetchedResults<Log>
    
    var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .short
        return formatter
    }

    var body: some View {
        List {
            ForEach(logs.filter({ $0.exercise == exercise })) { log in
                NavigationLink(destination: ExerciseRecordView(log: log)) {
                    Text(dateFormat.string(from: log.date!))
                }
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddExerciseLogView(exercise: exercise)) {
                    Image(systemName: "plus")
                }
            }
        }.navigationTitle(exercise.name!)
    }
}
