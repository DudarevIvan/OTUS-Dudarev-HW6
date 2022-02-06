//
//  SuffixModel.swift
//  OTUS-Dudarev-HW6
//
//  Created by Ivan Dudarev on 06.02.2022.
//

import Foundation

struct SuffixModel {
    func getSuffixes(of text: String) -> Array<Suffix> {
        SuffixSequence(of: text).suffixes
    }
}


// MARK: Suffix
struct Suffix: Codable, Identifiable, Equatable {
    let id: Int
    let value: String
    var numberOfMatches: Int = 1
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }
}


struct SuffixSequence {
    
    var suffixes: [Suffix] = .init()
    
    public init(of text: String) {
        // Only letters(without spacers)
        let wordsArray = text.split{!$0.isLetter}.map{String($0)}
        var buffer: Array<String> = .init()
        // Split words into suffixes
        for word in wordsArray {
            var parseWord = word
            while parseWord.count >= 3 {
                buffer.append(String(parseWord.prefix(3)))
                parseWord.removeFirst(3)
            }
            if !parseWord.isEmpty {
                buffer.append(parseWord)
            }
        }
        // Create Array<Suffix>
        var id = 0
        buffer.forEach { suffix in
            suffixes.append(Suffix(id: id, value: suffix, numberOfMatches: buffer.filter{$0.contains(suffix)}.count))
            id += 1
        }
    }
}

extension SuffixSequence: Sequence {
    func makeIterator() -> SuffixIterator {
        return SuffixIterator(suffixes)
    }
}


struct SuffixIterator: IteratorProtocol {
    
    private var _suffixes: Array<Suffix>
    
    init(_ suffixes: Array<Suffix>) {
        _suffixes = suffixes
    }
    
    mutating func next() -> Suffix? {
        defer {
            if !_suffixes.isEmpty { _suffixes.removeFirst() }
        }
        return _suffixes.first
    }
}
