//
//  Markov.swift
//  Markov
//
//  Created by elias on 10/3/15.
//  Copyright (c) 2015 nus.cs3217. All rights reserved.
//

import UIKit

class Markov {

    init() {

    }

    func readAndPrint() -> Dictionary<String, Dictionary<String, Float>> {
        let path = NSBundle.mainBundle().pathForResource("essay", ofType: "txt")
        var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!

        // strip ws
        var words = text.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter({!isEmpty($0)})

        words = words.map({ $0.hasSuffix(",") ? dropLast($0) : $0 })
        words = words.map({ $0.hasSuffix(".") ? dropLast($0) : $0 })

        var machine = Dictionary<String, Dictionary<String, Float>>()

        for word in words {
            if machine[word] == nil {
                machine[word] = Dictionary<String, Float>()
            }
        }

        var sum = 0
        var count = 1

        for word in words[1...words.count-1] {
            var w = words[count-1]

            if (machine[w]![word] == nil) {
                machine[w]![word] = Float(1)
            } else {
                machine[w]![word]? += 1.0
            }

            sum += 1
            count += 1
        }

        for a in machine.keys {
            for b in machine[a]!.keys {
                machine[a]![b] = machine[a]![b]! / Float(sum)
            }
        }

        println("done")

        return machine
    }

    func random(lower: Float, upper: Float) -> Float {
        let r = Float(arc4random()) /  Float(UInt32.max)
        return (r * (upper - lower)) + lower
    }

    func pickword(words :Dictionary<String, Float>) -> String {
        var total = Float(0)

        for word in words.keys {
            total += words[word]!
        }

        var target = random(0, upper: Float(total))

        var sum = Float(0)

        for word in words.keys {
            sum = sum + words[word]!

            if target < sum {
                return word
            }
        }

        return ""
    }

    func generate(count: Int) -> String {

        var markov = readAndPrint()
        var text: [String] = []

        var randIndex = Int(arc4random_uniform(UInt32(markov.count)))
        var nextWord = Array(markov.keys)[randIndex]

        for i in 1...count {
            var word = pickword(markov[nextWord]!)
            text.append(nextWord)
            nextWord = word
        }

        return " ".join(text)
    }
   
}
