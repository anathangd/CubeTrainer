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
    @State private var showVisibilityEditor = false
    @State private var showHelpPopup = false
    @AppStorage("mainButtonVisibility") private var mainButtonVisibilityData: String = ""

    private let hideableMainButtons: [String] = [
        "Simple OLL",
        "Simple PLL",
        "F2L",
        "Advanced F2L",
        "Continuous F2L",
        "Full OLL",
        "Full PLL",
        "PLL Rec Abridged",
        "PLL Recognition",
        "OLL Recognition Abridged",
        "OLL Recognition",
        "4X4 Parity",
        "Megaminx",
        "Export Times",
        "Import Times"
    ]
    var categories: [Category] = []

    init() {
        if let data = UserDefaults.standard.data(forKey: "needsWork"),
           let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
            _needsWorkArrayMain = State(initialValue: decoded)
        }
        categories = [
            Category(name: "Simple OLL", algorithms: [
                Algorithm(name: "Lshape", algorithm: "F U R U' R' F'", note: "6 times"),
                Algorithm(name: "line", algorithm: "F (R U R' U') F'", note: "6 times"),
                Algorithm(name: "dot", algorithm: "(R U2 R') (R' F R F') U2 (R' F R F')", note: "18 times"),
                Algorithm(name: "fishRight", algorithm: "(L' U2 L) U (L' U L)", note: "6 times"),
                Algorithm(name: "fishLeft", algorithm: "(R U2 R') U' (R U' R')", note: "6 times"),
                Algorithm(name: "diagonalLeft", algorithm: "F' (r U R' U') (r' F R)", note: "3 times"),
                Algorithm(name: "Tout90", algorithm: "(r U R' U') (r' F R F')", note: "3 times"),
                Algorithm(name: "crossMan90", algorithm: "R U2 (R2' U' R2 U')\n(R2' U2 R)", note: "6 times"),
                Algorithm(name: "cross", algorithm: "(R U R') U (R U' R') U\n(R U2 R')", note: "3 times"),
                Algorithm(name: "Tdown", algorithm: "R2 D (R' U2 R) D'\n(R' U2 R')", note: "3 times")
            ]),
            Category(name: "Simple PLL", algorithms: [
                Algorithm(name: "headlights", algorithm: "x (R2 D2) (R U R') D2\n(R U' R)", note: "3 times"),
                Algorithm(name: "noHL", algorithm: "F R U' R' U' R U R' F' (R U R' U') (gR' F R F')", note: "2 times"),
                Algorithm(name: "Ub", algorithm: "M2 U' M U2 M' U' M2", note: "3 times"),
                Algorithm(name: "Ua", algorithm: "M2 U M U2 M' U M2", note: "3 times"),
                Algorithm(name: "H", algorithm: "(M2 U' M2) U2\n(M2 U' M2)", note: "2 times"),
                Algorithm(name: "Z", algorithm: "M' U' M2 U' M2\nU' M' U2 M2 U", note: "2 times")
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

    private var hiddenMainButtons: Set<String> {
        get {
            guard !mainButtonVisibilityData.isEmpty else { return [] }
            return Set(mainButtonVisibilityData.split(separator: "|").map(String.init))
        }
        nonmutating set {
            mainButtonVisibilityData = newValue.sorted().joined(separator: "|")
        }
    }

    private func isMainButtonVisible(_ name: String) -> Bool {
        !hiddenMainButtons.contains(name)
    }

    private func toggleMainButtonVisibility(_ name: String) {
        var hidden = hiddenMainButtons
        if hidden.contains(name) {
            hidden.remove(name)
        } else {
            hidden.insert(name)
        }
        hiddenMainButtons = hidden
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .ignoresSafeArea()
                // Watch connected indicator
//                VStack {
//                    HStack {
//                        Spacer()
//                        Text(isConnected ? "✅" : "⚠️")
//                            .font(.footnote)
//                            .padding(.horizontal, 20)
//                            .padding(.top, -10)
//                    }
//                    Spacer()
//                }
                
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
                            
                            if isMainButtonVisible("Simple OLL"),
                               let category = categories.first(where: { $0.name == "Simple OLL" }),
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

                            if isMainButtonVisible("Simple PLL"),
                               let category = categories.first(where: { $0.name == "Simple PLL" }),
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

                            if isMainButtonVisible("F2L") {
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
                            }

                            if isMainButtonVisible("Advanced F2L") {
                                NavigationLink(destination: AdvancedF2LView()) {
                                    Text("Advanced F2L >")
                                        .capsuleButtonStyle(color: .red)
                                }
                            }
                            
                            if isMainButtonVisible("Continuous F2L") {
                                let advancedF2LAlgorithms = AdvancedF2LAlgorithms.categories.flatMap { $0.algorithms }
                                let continuousF2LAlgorithms = F2LAlgorithms.algorithms + advancedF2LAlgorithms
                                let contF2L = Category(name: "Continuous F2L", algorithms: continuousF2LAlgorithms)
                                Button(action: {
                                    selectedCategoryForIndividual = contF2L
                                    showIndividualView = true
                                }) {
                                    Text("\(contF2L.name) (\(contF2L.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = contF2L
                                        showListView = true
                                    }
                                )
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
                            
                            if isMainButtonVisible("Full OLL") {
                                NavigationLink(destination: FullOLLView()) {
                                    Text("Full OLL >")
                                        .capsuleButtonStyle(color: .red)
                                }
                            }

                            if isMainButtonVisible("Full PLL") {
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
                            }

                            if isMainButtonVisible("PLL Rec Abridged") {
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
                            }

                            if isMainButtonVisible("PLL Recognition") {
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
                            }
                            
                            if isMainButtonVisible("OLL Rec Abridged") {
                                let ollrecabr = Category(name: "OLL Rec Abridged", algorithms: OLLRecognitionCasesAbridged.cases)
                                Button(action: {
                                    selectedCategoryForIndividual = ollrecabr
                                    showIndividualView = true
                                }) {
                                    Text("\(ollrecabr.name) (\(ollrecabr.algorithms.count))")
                                        .capsuleButtonStyle()
                                }
                                .highPriorityGesture(
                                    LongPressGesture().onEnded { _ in
                                        showIndividualView = false
                                        selectedCategoryForList = ollrecabr
                                        showListView = true
                                    }
                                )
                            }

                            if isMainButtonVisible("OLL Recognition") {
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
                            }

                            if isMainButtonVisible("4X4 Parity"),
                               let category = categories.first(where: { $0.name == "4X4 Parity" }),
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

                            if isMainButtonVisible("Megaminx") {
                                NavigationLink(destination: MegaminxView()) {
                                    Text("Megaminx >")
                                        .capsuleButtonStyle()
                                }
                            }

                            if isMainButtonVisible("Export Times") {
                                Button(action: {
                                    exportDocument = RubiksTrainerJSONDocument(export: buildExport())
                                    isExporting = true
                                }) {
                                    Text("Export Times")
                                        .capsuleButtonStyle(color: .green)
                                }
                            }

                            if isMainButtonVisible("Import Times") {
                                Button(action: {
                                    isImporting = true
                                }) {
                                    Text("Import Times")
                                        .capsuleButtonStyle(color: .green)
                                }
                            }
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

                VStack {
                    Spacer()
                    HStack {
                        Button {
                            withAnimation(.spring()) {
                                showHelpPopup.toggle()
                            }
                        } label: {
                            Image(systemName: "questionmark")
                                .font(.system(size: 20))
                                .foregroundStyle(.gray)
                                .padding(.leading, 12)
                                .padding(12)
                        }
                        .buttonStyle(.plain)
                        Spacer()
                        Button {
                            withAnimation(.spring()) {
                                showVisibilityEditor.toggle()
                            }
                        } label: {
                            Image(systemName: "list.bullet.circle.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.blue)
                                .padding(12)
                        }
                        .buttonStyle(.plain)
                    }
                }

                if showHelpPopup {
                    Rectangle()
                        .fill(.clear)
                        .ignoresSafeArea()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showHelpPopup = false
                            }
                        }

                    VStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Tips")
                                .font(.headline)
                                .foregroundStyle(.black)

                            Text("Long press the solve count to bring up the minus button in case you want to decrease the count.")
                                .foregroundStyle(.black)
                                .font(.subheadline)

                            Text("Long press a category to bring up the list view.")
                                .foregroundStyle(.black)
                                .font(.subheadline)
                        }
                        .padding()
                        .background(.white.opacity(0.94), in: RoundedRectangle(cornerRadius: 18))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 70)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                if showVisibilityEditor {
                    Rectangle()
                        .fill(.clear)
                        .ignoresSafeArea()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showVisibilityEditor = false
                            }
                        }

                    VStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Show Buttons")
                                .font(.headline)
                                .foregroundStyle(.black)

                            ForEach(hideableMainButtons, id: \.self) { name in
                                Button {
                                    toggleMainButtonVisibility(name)
                                } label: {
                                    HStack {
                                        Image(systemName: isMainButtonVisible(name) ? "checkmark.circle.fill" : "circle")
                                            .foregroundStyle(.black)
                                        Text(name)
                                            .foregroundStyle(.black)
                                        Spacer()
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                        .background(.white.opacity(0.92), in: RoundedRectangle(cornerRadius: 18))
                        .padding(.horizontal, 18)
                        .padding(.bottom, 60)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
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
                    print("✅ Imported \(decoded.solveTimes.count) solves + \(decoded.cfopSolveTimes.count) CFOP entries, solveCount=\(decoded.solveCount), needsWork=\(decoded.needsWork.count)")
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

        let needsWork: [Algorithm]
        if let data = UserDefaults.standard.data(forKey: "needsWork"),
           let decoded = try? JSONDecoder().decode([Algorithm].self, from: data) {
            needsWork = decoded
        } else {
            needsWork = []
        }

        let hiddenButtons = Array(hiddenMainButtons)

        return RubiksTrainerExport(
            solveTimes: solveDTOs,
            cfopSolveTimes: cfopDTOs,
            solveCount: solveCountModel.count,
            needsWork: needsWork,
            hiddenMainButtons: hiddenButtons
        )
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

        // Restore solve count
        solveCountModel.count = export.solveCount

        // Restore needs-work array
        if !export.needsWork.isEmpty,
           let encoded = try? JSONEncoder().encode(export.needsWork) {
            UserDefaults.standard.set(encoded, forKey: "needsWork")
            needsWorkArrayMain = export.needsWork
            print("✅ Restored \(export.needsWork.count) needs-work algorithms")
        }

        // Restore main button visibility
        if !export.hiddenMainButtons.isEmpty {
            hiddenMainButtons = Set(export.hiddenMainButtons)
            print("✅ Restored \(export.hiddenMainButtons.count) hidden main buttons")
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
    var version: Int = 2
    var exportedAt: Date = .now
    var solveTimes: [SolveTimeDTO]
    var cfopSolveTimes: [CFOPSolveTimeDTO]
    var solveCount: Int = 0
    var needsWork: [Algorithm] = []
    var hiddenMainButtons: [String] = []
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
