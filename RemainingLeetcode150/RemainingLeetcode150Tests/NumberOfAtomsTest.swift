//
//  NumberOfAtomsTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/11/24.
//

/*
 Given a string formula representing a chemical formula, return the count of each atom.
 The atomic element always starts with an uppercase character, then zero or more lowercase letters, representing the name.
 One or more digits representing that element's count may follow if the count is greater than 1. If the count is 1, no digits will follow.
 For example, "H2O" and "H2O2" are possible, but "H1O2" is impossible.
 Two formulas are concatenated together to produce another formula.
 For example, "H2O2He3Mg4" is also a formula.
 A formula placed in parentheses, and a count (optionally added) is also a formula.
 For example, "(H2O2)" and "(H2O2)3" are formulas.
 Return the count of all elements as a string in the following form: the first name (in sorted order), followed by its count (if that count is more than 1), followed by the second name (in sorted order), followed by its count (if that count is more than 1), and so on.
 The test cases are generated so that all the values in the output fit in a 32-bit integer.

 Example 1:
 Input: formula = "H2O"
 Output: "H2O"
 Explanation: The count of elements are {'H': 2, 'O': 1}.

 Example 2:
 Input: formula = "Mg(OH)2"
 Output: "H2MgO2"
 Explanation: The count of elements are {'H': 2, 'Mg': 1, 'O': 2}.

 Example 3:
 Input: formula = "K4(ON(SO3)2)2"
 Output: "K4N2O14S4"
 Explanation: The count of elements are {'K': 4, 'N': 2, 'O': 14, 'S': 4}.

 Constraints:
 1 <= formula.length <= 1000
 formula consists of English letters, digits, '(', and ')'.
 formula is always valid.
 */

import Testing

struct NumberOfAtomsTest {

    class Solution {
        func countOfAtoms(_ formula: String) -> String {
            var stack = [Dictionary<String, Int>]()
            stack.append([:])

            var i = 0
            while i < formula.count {
                let char = formula[formula.index(formula.startIndex, offsetBy: i)]

                if char == "(" {
                    stack.append([:])
                    i += 1
                } else if char == ")" {
                    i += 1
                    var multiplier = 0
                    while i < formula.count, let digit = Int(String(formula[formula.index(formula.startIndex, offsetBy: i)])) {
                        multiplier = multiplier * 10 + digit
                        i += 1
                    }
                    if multiplier == 0 {
                        multiplier = 1
                    }

                    let lastDict = stack.removeLast()
                    var currentDict = stack.last!
                    for (atom, count) in lastDict {
                        currentDict[atom, default: 0] += count * multiplier
                    }
                    stack[stack.count - 1] = currentDict
                } else {
                    var j = i
                    while j + 1 < formula.count, formula[formula.index(formula.startIndex, offsetBy: j + 1)].isLowercase {
                        j += 1
                    }
                    let atom = String(formula[formula.index(formula.startIndex, offsetBy: i)...formula.index(formula.startIndex, offsetBy: j)])
                    i = j + 1

                    var count = 0
                    while i < formula.count, let digit = Int(String(formula[formula.index(formula.startIndex, offsetBy: i)])) {
                        count = count * 10 + digit
                        i += 1
                    }
                    if count == 0 {
                        count = 1
                    }

                    stack[stack.count - 1][atom, default: 0] += count
                }
            }

            let finalDict = stack.removeLast()
            let sortedAtoms = finalDict.keys.sorted()

            var result = ""
            for atom in sortedAtoms {
                result += atom
                if finalDict[atom]! > 1 {
                    result += String(finalDict[atom]!)
                }
            }

            return result
        }
    }

    @Test func example1() {
        let solution = Solution()
        #expect(solution.countOfAtoms("H2O") == "H2O")
    }

    @Test func example2() {
        let solution = Solution()
        #expect(solution.countOfAtoms("Mg(OH)2") == "H2MgO2")
    }

    @Test func example3() {
        let solution = Solution()
        #expect(solution.countOfAtoms("K4(ON(SO3)2)2") == "K4N2O14S4")
    }

}
