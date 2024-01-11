//
//  Persistence.swift
//  workout
//
//  Created by 國吉宏一郎 on 2023/08/20.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        let region1 = Region(context: viewContext)
        let region2 = Region(context: viewContext)
        let region3 = Region(context: viewContext)
        let region4 = Region(context: viewContext)
        let region5 = Region(context: viewContext)
        let region6 = Region(context: viewContext)
        let exercise1 = Exercise(context: viewContext)
        let exercise1_2 = Exercise(context: viewContext)
        let exercise2 = Exercise(context: viewContext)
        let exercise3 = Exercise(context: viewContext)
        let exercise4 = Exercise(context: viewContext)
        let exercise5 = Exercise(context: viewContext)
        let exercise6 = Exercise(context: viewContext)
        let type1 = Type(context: viewContext)
        let type2 = Type(context: viewContext)
        let type3 = Type(context: viewContext)
        let type4 = Type(context: viewContext)
        let log1 = Log(context: viewContext)
        let record1 = Record(context: viewContext)
        let record2 = Record(context: viewContext)
        
        region1.name = "肩"
        region1.order = 1
        region2.name = "胸"
        region2.order = 2
        region3.name = "背中"
        region3.order = 3
        region4.name = "腹"
        region4.order = 4
        region5.name = "脚"
        region5.order = 5
        region6.name = "その他"
        region6.order = 6
        
        type1.name = "フリーウェイト"
        type1.order = 1
        type2.name = "マシン"
        type2.order = 2
        type3.name = "自重"
        type3.order = 3
        type4.name = "有酸素"
        type4.order = 4
        
        record1.weight = 60
        record1.rep = 10
        record1.set = 1
        record2.weight = 60
        record2.rep = 10
        record2.set = 2
        
        log1.date = Date()
        log1.exercise = exercise1
        log1.records = NSSet(array: [record1, record2])
        
        exercise1.name = "ショルダープレス"
        exercise1.region = region1
        exercise1.order = 0
        exercise1_2.name = "サイドレイズ"
        exercise1_2.region = region1
        exercise1_2.order = 1
        exercise2.name = "ベンチプレス"
        exercise2.region = region2
        exercise2.order = 0
        exercise3.name = "ラットプルダウン"
        exercise3.region = region3
        exercise3.order = 0
        exercise4.name = "腹筋"
        exercise4.region = region4
        exercise4.order = 0
        exercise5.name = "スクワット"
        exercise5.region = region5
        exercise5.order = 0
        exercise6.name = "ランニング"
        exercise6.region = region6
        exercise6.order = 0
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "workout")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
