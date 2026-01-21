//
//  ContentView.swift
//  RubiksCubeTrainer
//
//  Created by Nathan Davis on 2025-03-20.
//

import SwiftUI
import WatchConnectivity
import SwiftData
import UniformTypeIdentifiers

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SolveTime.date, order: .forward) private var solveTimes: [SolveTime]
    @Query(sort: \CFOPSolveTime.date, order: .forward) private var cfopSolveTimes: [CFOPSolveTime]

    @EnvironmentObject var solveCountModel: SolveCountModel
    @EnvironmentObject var connectivity: PhoneConnectivity
    var isConnected: Bool {
        WCSession.default.isReachable
    }

    // Export / Import
    @State private var isExporting = false
    @State private var isImporting = false
    @State private var exportDocument = RubiksTrainerJSONDocument(
        export: RubiksTrainerExport(solveTimes: [], cfopSolveTimes: [])
    )
    let color = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    @State var editCount = false
    // Start with empty array; load from UserDefaults if available
    @State private var needsWorkArrayMain: [Algorithm] = []
    var categories: [Category] = []

    init() {
        if let data = UserDefaults.standard.data(forKey: "needsWork"),
           let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
            _needsWorkArrayMain = State(initialValue: decoded)
        }
        categories = [
            Category(name: "Simple OLL", algorithms: [
                Algorithm(name: "Lshape", algorithm: "F U R U' R' F'", note: "6 times"),
                Algorithm(name: "line", algorithm: "F R U R' U' F'", note: "6 times"),
                Algorithm(name: "dot", algorithm: "gR U2 (R2' gF R F') U2\n(R' F R F')", note: "18 times"),
                Algorithm(name: "fishRight", algorithm: "(L' U2 L) U (L' U L)", note: "6 times"),
                Algorithm(name: "fishLeft", algorithm: "(R U2 R') U' (R U' R')", note: "6 times"),
                Algorithm(name: "diagonalLeft", algorithm: "F' (r U R' U') (gr' F R)", note: "3 times"),
                Algorithm(name: "Tout90", algorithm: "(gr U R' U') (gr' F R F')", note: "3 times"),
                Algorithm(name: "crossMan90", algorithm: "R U2 (R2' U' R2 U')\n(R2' U2 R)", note: "6 times"),
                Algorithm(name: "cross", algorithm: "(gR U R') gU (R U' R') U\n(R U2 R')", note: "3 times"),
                Algorithm(name: "Tdown", algorithm: "R2 D (R' U2 R) D'\n(R' U2 R')", note: "3 times")
            ]),
            Category(name: "Simple PLL", algorithms: [
                Algorithm(name: "headlights", algorithm: "x (R2 D2) (R U R') D2\n(R U' R)", note: "3 times"),
                Algorithm(name: "noHL", algorithm: "F R U' R' U' R U R' F' (R U R' U') (gR' F R F')", note: "2 times"),
                Algorithm(name: "cwEdges", algorithm: "M2 U' M U2 M' U' M2", note: "3 times"),
                Algorithm(name: "ccwEdges", algorithm: "M2 U M U2 M' U M2", note: "3 times"),
                Algorithm(name: "swap180", algorithm: "(M2 U' M2) U2\n(M2 U' M2)", note: "2 times"),
                Algorithm(name: "swapAdj", algorithm: "M' U' M2 U' M2\nU' M' U2 M2 U", note: "2 times")
            ]),
            Category(name: "4X4 Parity", algorithms: [
                Algorithm(name: "four inline", algorithm: "Rw U2, X, Rw U2, Rw U2,\nRw' U2, Lw U2, Rw' U2,\nRw U2, Rw' U2, Rw'", note: "2 times"), //verified
                Algorithm(name: "single edge", algorithm: "r' U2 l F2 l' F2 r2 U2\nr U2 r' U2 F2 r2 F2", note: "2 times"), //verified
                Algorithm(name: "opposite edges", algorithm: "r2 U2 r2 Uw2 r2 u2", note: "2 times"), //verified
                Algorithm(name: "adjacent edges", algorithm: "(R' U R U') r2 U2 r2 Uw2\nr2 u2 (U R' U' R)", note: "2 times"), //verified
            ]),
            Category(name: "Needs Work", algorithms: needsWorkArrayMain)
        ]
    }
    @State var selectedCategoryForList: Category?
    @State var showListView = false
    @State var selectedCategoryForIndividual: Category?
    @State var showIndividualView = false
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .ignoresSafeArea()
                // Watch connected indicator
                VStack {
                    HStack {
                        Spacer()
                        Text(isConnected ? "✅" : "⚠️")
                            .font(.footnote)
                            .padding(.horizontal, 20)
                            .padding(.top, -10)
                    }
                    Spacer()
                }
                
                VStack {
                    Text("Rubik's Cube Trainer!")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(.top, 65)
                    Spacer()
                    ScrollView(showsIndicators: false) {
                        VStack {
                            NavigationLink(destination: TimerView()) {
                                Text("Timer")
                                    .capsuleButtonStyle()
                            }
                            
                            NavigationLink(destination: CFOPStepTimerView()) {
                                Text("CFOP Step Timer")
                                    .capsuleButtonStyle()
                            }
                            
                            //                        NavigationLink(destination: IndividualCategoryView(category: categories.first { $0.name == "Simple OLL" }!)) {
                            //                            Text("Simple OLL")
                            //                                .capsuleButtonStyle()
                            //                        }
                            //
                            //                        NavigationLink(destination: IndividualCategoryView(category: categories.first { $0.name == "Simple PLL" }!)) {
                            //                            Text("Simple PLL")
                            //                                .capsuleButtonStyle()
                            //                        }
                            
                            let category = Category(name: "F2L", algorithms: F2LAlgorithms.algorithms)
                                Button(action: {
                                    selectedCategoryForIndividual = category
                                    showIndividualView = true
                                }) {
                                    Text("\(category.name) (\(category.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = category
                                        showListView = true
                                    }
                                )
                            
                            NavigationLink(destination: AdvancedF2LView()) {
                                Text("Advanced F2L >")
                                    .capsuleButtonStyle(color: .red)
                            }
                            
                            if !needsWorkArrayMain.isEmpty {
                                NavigationLink(
                                        destination: IndividualCategoryView(
                                            category: Category(name: "Needs Work", algorithms: needsWorkArrayMain)
                                        )
                                    ) {
                                    Text("Weak Algorithms (\(needsWorkArrayMain.count))")
                                        .capsuleButtonStyle()
                                }
                            }
                            
                            NavigationLink(destination: FullOLLView()) {
                                Text("Full OLL >")
                                    .capsuleButtonStyle(color: .red)
                            }
                            
                            let fullPLL = Category(name: "Full PLL", algorithms: FullPLLAlgorithms.algorithms)
                                Button(action: {
                                    selectedCategoryForIndividual = fullPLL
                                    showIndividualView = true
                                }) {
                                    Text("\(fullPLL.name) (\(fullPLL.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = fullPLL
                                        showListView = true
                                    }
                                )
                            
                            let pllabridged = Category(name: "PLL Rec Abridged", algorithms: PLLRecognitionAbridgedCases.cases)
                                Button(action: {
                                    selectedCategoryForIndividual = pllabridged
                                    showIndividualView = true
                                }) {
                                    Text("\(pllabridged.name) (\(pllabridged.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = pllabridged
                                        showListView = true
                                    }
                                )
                            
                            let pllrec = Category(name: "PLL Recognition", algorithms: PLLRecognitionCases.cases)
                                Button(action: {
                                    selectedCategoryForIndividual = pllrec
                                    showIndividualView = true
                                }) {
                                    Text("\(pllrec.name) (\(pllrec.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = pllrec
                                        showListView = true
                                    }
                                )
                            
                            let ollrec = Category(name: "OLL Recognition", algorithms: OLLRecognitionCases.cases)
                                Button(action: {
                                    selectedCategoryForIndividual = ollrec
                                    showIndividualView = true
                                }) {
                                    Text("\(ollrec.name) (\(ollrec.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = ollrec
                                        showListView = true
                                    }
                                )
                            
                            if let category = categories.first(where: { $0.name == "4X4 Parity" }),
                               !category.algorithms.isEmpty {
                                Button(action: {
                                    selectedCategoryForIndividual = category
                                    showIndividualView = true
                                }) {
                                    Text("\(category.name) (\(category.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = category
                                        showListView = true
                                    }
                                )
                            }
                            
                            NavigationLink(destination: MegaminxView()) {
                                Text("Megaminx >")
                                    .capsuleButtonStyle()
                            }
                            
                            Button(action: {
                                exportDocument = RubiksTrainerJSONDocument(export: buildExport())
                                isExporting = true
                            }) {
                                Text("Export Times")
                                    .capsuleButtonStyle(color: .green)
                            }

                            Button(action: {
                                isImporting = true
                            }) {
                                Text("Import Times")
                                    .capsuleButtonStyle(color: .green)
                            }
                            
//                            NavigationLink(destination: RoofpigTestView()) {
//                                Text("Roofpig Test >")
//                                    .capsuleButtonStyle(color: .red)
//                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .onTapGesture {
                        editCount = false
                    }
                    Spacer()
                }
                .ignoresSafeArea()
                SolveCountButton(editCount: $editCount)
                    .padding(.top, 15)
            }
            .fileExporter(
                isPresented: $isExporting,
                document: exportDocument,
                contentType: .json,
                defaultFilename: "RubiksCubeTrainer-Export"
            ) { result in
                switch result {
                case .success(let url):
                    print("✅ Exported to: \(url)")
                case .failure(let error):
                    print("❌ Export failed: \(error)")
                }
            }
            .fileImporter(
                isPresented: $isImporting,
                allowedContentTypes: [.json]
            ) { result in
                do {
                    let url = try result.get()
                    let gotAccess = url.startAccessingSecurityScopedResource()
                    defer { if gotAccess { url.stopAccessingSecurityScopedResource() } }

                    let data = try Data(contentsOf: url)
                    let decoded = try JSONDecoder.rubiks.decode(RubiksTrainerExport.self, from: data)
                    importExport(decoded)
                    print("✅ Imported \(decoded.solveTimes.count) solves + \(decoded.cfopSolveTimes.count) CFOP entries")
                } catch {
                    print("❌ Import failed: \(error)")
                }
            }
            .navigationDestination(isPresented: $showIndividualView) {
                IndividualCategoryView(category: selectedCategoryForIndividual ?? categories.first!)
            }
            .navigationDestination(isPresented: $showListView) {
                ListView(category: selectedCategoryForList ?? categories.first!)
            }
            .onAppear {
                if let data = UserDefaults.standard.data(forKey: "needsWork"),
                   let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
                    needsWorkArrayMain = decoded
                    print("✅ Refreshed needsWorkArrayMain: \(decoded.count) items")
                } else {
                    needsWorkArrayMain = []
                    print("⚠️ No needsWork data found")
                }
                if WCSession.default.isReachable {
                    let solveCount = solveCountModel.count
                    WCSession.default.sendMessage(["solveCount": solveCount]) { response in
                        print("✅ Watch responded: \(response)")
                    } errorHandler: { error in
                        print("❌ Failed to send message: \(error.localizedDescription)")
                    }
                } else {
                    print("⚠️ Watch not reachable right now")
                }
            }
        }
    }
    // MARK: - Export / Import helpers

    private func buildExport() -> RubiksTrainerExport {
        let solveDTOs = solveTimes.map {
            SolveTimeDTO(solveTime: $0.solveTime, memo: $0.memo, date: $0.date)
        }

        let cfopDTOs = cfopSolveTimes.map {
            CFOPSolveTimeDTO(
                crossSolveTime: $0.crossSolveTime,
                f2LSolveTime: $0.f2LSolveTime,
                ollSolveTime: $0.ollSolveTime,
                pllSolveTime: $0.pllSolveTime,
                memo: $0.memo,
                date: $0.date
            )
        }

        return RubiksTrainerExport(solveTimes: solveDTOs, cfopSolveTimes: cfopDTOs)
    }

    private func importExport(_ export: RubiksTrainerExport) {
        // De-dupe keys to avoid duplicates on repeated imports.
        let existingSolveKeys = Set(solveTimes.map { keyForSolve(time: $0.solveTime, memo: $0.memo, date: $0.date) })
        let existingCFOPKeys = Set(cfopSolveTimes.map { keyForCFOP($0) })

        for dto in export.solveTimes {
            let key = keyForSolve(time: dto.solveTime, memo: dto.memo, date: dto.date)
            if !existingSolveKeys.contains(key) {
                modelContext.insert(SolveTime(solveTime: dto.solveTime, memo: dto.memo, date: dto.date))
            }
        }

        for dto in export.cfopSolveTimes {
            let key = keyForCFOP(dto)
            if !existingCFOPKeys.contains(key) {
                modelContext.insert(
                    CFOPSolveTime(
                        crossSolveTime: dto.crossSolveTime,
                        f2LSolveTime: dto.f2LSolveTime,
                        ollSolveTime: dto.ollSolveTime,
                        pllSolveTime: dto.pllSolveTime,
                        memo: dto.memo,
                        date: dto.date
                    )
                )
            }
        }

        do {
            try modelContext.save()
        } catch {
            print("❌ Save after import failed: \(error)")
        }
    }

    private func keyForSolve(time: TimeInterval, memo: String, date: Date) -> String {
        "\(date.timeIntervalSince1970)|\(time)|\(memo)"
    }

    private func keyForCFOP(_ obj: CFOPSolveTime) -> String {
        "\(obj.date.timeIntervalSince1970)|\(obj.crossSolveTime)|\(obj.f2LSolveTime)|\(obj.ollSolveTime)|\(obj.pllSolveTime)|\(obj.memo)"
    }

    private func keyForCFOP(_ dto: CFOPSolveTimeDTO) -> String {
        "\(dto.date.timeIntervalSince1970)|\(dto.crossSolveTime)|\(dto.f2LSolveTime)|\(dto.ollSolveTime)|\(dto.pllSolveTime)|\(dto.memo)"
    }
}

// MARK: - Export / Import Models

private struct SolveTimeDTO: Codable, Hashable {
    var solveTime: TimeInterval
    var memo: String
    var date: Date
}

private struct CFOPSolveTimeDTO: Codable, Hashable {
    var crossSolveTime: TimeInterval
    var f2LSolveTime: TimeInterval
    var ollSolveTime: TimeInterval
    var pllSolveTime: TimeInterval
    var memo: String
    var date: Date
}

private struct RubiksTrainerExport: Codable {
    var version: Int = 1
    var exportedAt: Date = .now
    var solveTimes: [SolveTimeDTO]
    var cfopSolveTimes: [CFOPSolveTimeDTO]
}

private struct RubiksTrainerJSONDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.json] }

    var export: RubiksTrainerExport

    init(export: RubiksTrainerExport) {
        self.export = export
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.export = try JSONDecoder.rubiks.decode(RubiksTrainerExport.self, from: data)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder.rubiks.encode(export)
        return .init(regularFileWithContents: data)
    }
}

private extension JSONEncoder {
    static var rubiks: JSONEncoder {
        let e = JSONEncoder()
        e.outputFormatting = [.prettyPrinted, .sortedKeys]
        e.dateEncodingStrategy = .iso8601
        return e
    }
}

private extension JSONDecoder {
    static var rubiks: JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [SolveTime.self, CFOPSolveTime.self])
        .environmentObject(SolveCountModel())
}
