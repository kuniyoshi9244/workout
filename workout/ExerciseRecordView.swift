//
//  File.swift
//  workout
//
//  Created by 國吉宏一郎 on 2023/08/25.
//

import SwiftUI
import CoreData

struct ExerciseRecordView: View{
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var log: Log
        
    var body: some View {
        List {
            
        }.navigationTitle("記録")
    }
}