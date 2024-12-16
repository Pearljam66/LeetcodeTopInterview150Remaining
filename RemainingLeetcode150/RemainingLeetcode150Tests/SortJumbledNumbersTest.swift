//
//  SortJumbledNumbersTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/16/24.
//

/*
 You are given a 0-indexed integer array mapping which represents the mapping rule of a shuffled decimal system. mapping[i] = j means digit i should be mapped to digit j in this system.
 The mapped value of an integer is the new integer obtained by replacing each occurrence of digit i in the integer with mapping[i] for all 0 <= i <= 9.
 You are also given another integer array nums. Return the array nums sorted in non-decreasing order based on the mapped values of its elements.

 Notes:
 Elements with the same mapped values should appear in the same relative order as in the input.
 The elements of nums should only be sorted based on their mapped values and not be replaced by them.

 Example 1:
 Input: mapping = [8,9,4,0,2,1,3,5,7,6], nums = [991,338,38]
 Output: [338,38,991]
 Explanation:
 Map the number 991 as follows:
 1. mapping[9] = 6, so all occurrences of the digit 9 will become 6.
 2. mapping[1] = 9, so all occurrences of the digit 1 will become 9.
 Therefore, the mapped value of 991 is 669.
 338 maps to 007, or 7 after removing the leading zeros.
 38 maps to 07, which is also 7 after removing leading zeros.
 Since 338 and 38 share the same mapped value, they should remain in the same relative order, so 338 comes before 38.
 Thus, the sorted array is [338,38,991].

 Example 2:
 Input: mapping = [0,1,2,3,4,5,6,7,8,9], nums = [789,456,123]
 Output: [123,456,789]
 Explanation: 789 maps to 789, 456 maps to 456, and 123 maps to 123. Thus, the sorted array is [123,456,789].

 Constraints:
 mapping.length == 10
 0 <= mapping[i] <= 9
 All the values of mapping[i] are unique.
 1 <= nums.length <= 3 * 104
 0 <= nums[i] < 109
 */

import Testing

struct SortJumbledNumbersTest {

    class Solution {
        func sortJumbled(_ mapping: [Int], _ nums: [Int]) -> [Int] {
            // Create tuple array to store original index and mapped value
            var mappedNums: [(index: Int, original: Int, mapped: Int)] = []

            // Convert each number and store with its original index
            for (index, num) in nums.enumerated() {
                let mapped = getMappedValue(num, mapping)
                mappedNums.append((index, num, mapped))
            }

            // Sort based on mapped value, then original index for stable sort
            mappedNums.sort { (a, b) -> Bool in
                if a.mapped == b.mapped {
                    return a.index < b.index // Maintain relative order for same mapped values
                }
                return a.mapped < b.mapped
            }

            // Return original numbers in sorted order
            return mappedNums.map { $0.original }
        }

        private func getMappedValue(_ num: Int, _ mapping: [Int]) -> Int {
            if num == 0 {
                return mapping[0]
            }

            var n = num
            var mapped = 0
            var multiplier = 1

            // Convert each digit using the mapping
            while n > 0 {
                let digit = n % 10
                mapped += mapping[digit] * multiplier
                multiplier *= 10
                n /= 10
            }

            return mapped
        }
    }

    @Test func example1() {
        let mapping: [Int] = [8,9,4,0,2,1,3,5,7,6]
        let nums: [Int] = [991,338,38]
        let expected: [Int] = [338,38,991]
        #expect(Solution().sortJumbled(mapping, nums) == expected)
    }

    @Test func example2() {
        let mapping: [Int] = [0,1,2,3,4,5,6,7,8,9]
        let nums: [Int] = [789,456,123]
        let expected: [Int] = [123,456,789]
        #expect(Solution().sortJumbled(mapping, nums) == expected)
    }

    @Test func example3() {
        let mapping: [Int] = [9,8,7,6,5,4,3,2,1,0]
        let nums: [Int] = [0,1,2,3,4,5,6,7,8,9]
        let expected: [Int] = [9,8,7,6,5,4,3,2,1,0]
        #expect(Solution().sortJumbled(mapping, nums) == expected)
    }

    @Test func example4() {
        let mapping: [Int] = [1,2,3,4,5,6,7,8,9,0]
        let nums: [Int] = [90,90,9990,90,90,9990,990,90,99990,0,990,90,9990,90,990,90,0,990,0,0,0]
        let expected: [Int] = [90,90,9990,90,90,9990,990,90,99990,0,990,90,9990,90,990,90,0,990,0,0,0]
        #expect(Solution().sortJumbled(mapping, nums) == expected)
    }

}
