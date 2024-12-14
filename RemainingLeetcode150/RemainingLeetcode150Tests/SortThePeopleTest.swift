//
//  SortThePeopleTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/14/24.
//

/*
 You are given an array of strings names, and an array heights that consists of distinct positive integers. Both arrays are of length n.
 For each index i, names[i] and heights[i] denote the name and height of the ith person.
 Return names sorted in descending order by the people's heights.

 Example 1:
 Input: names = ["Mary","John","Emma"], heights = [180,165,170]
 Output: ["Mary","Emma","John"]
 Explanation: Mary is the tallest, followed by Emma and John.

 Example 2:
 Input: names = ["Alice","Bob","Bob"], heights = [155,185,150]
 Output: ["Bob","Alice","Bob"]
 Explanation: The first Bob is the tallest, followed by Alice and the second Bob.

 Constraints:
 n == names.length == heights.length
 1 <= n <= 103
 1 <= names[i].length <= 20
 1 <= heights[i] <= 105
 names[i] consists of lower and upper case English letters.
 All the values of heights are distinct.
 */

import Testing

struct SortThePeopleTest {

    class Solution {
        func sortPeople(_ names: [String], _ heights: [Int]) -> [String] {
            // Pair each name with its corresponding height
            let pairedArray = zip(names, heights)

            // Sort the paired array by height in descending order
            let sortedArray = pairedArray.sorted { $0.1 > $1.1 }

            // Extract the names from the sorted array
            let sortedNames = sortedArray.map { $0.0 }

            return sortedNames
        }
    }

    @Test func example1() throws {
        let solution = Solution()
        #expect(solution.sortPeople(["Mary","John","Emma"], [180,165,170]) == ["Mary","Emma","John"])
    }

    @Test func example2() throws {
        let solution = Solution()
        #expect(solution.sortPeople(["Alice","Bob","Bob"], [155,185,150]) == ["Bob","Alice","Bob"])
    }

}
