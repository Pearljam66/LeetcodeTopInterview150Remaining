//
//  FindFirstLastPositionElementSortedArrayTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/6/24.
//

/*
 Given an array of integers nums sorted in non-decreasing order, find the starting and ending position of a given target value.
 If target is not found in the array, return [-1, -1].
 You must write an algorithm with O(log n) runtime complexity.

 Example 1:
 Input: nums = [5,7,7,8,8,10], target = 8
 Output: [3,4]

 Example 2:
 Input: nums = [5,7,7,8,8,10], target = 6
 Output: [-1,-1]

 Example 3:
 Input: nums = [], target = 0
 Output: [-1,-1]

 Constraints:
 0 <= nums.length <= 105
 -109 <= nums[i] <= 109
 nums is a non-decreasing array.
 -109 <= target <= 109
 */

import Testing

struct FindFirstLastPositionElementSortedArrayTest {

    class Solution {
        func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
            let lowerBound = nums.firstIndex(of: target) ?? -1
            let upperBound = nums.lastIndex(of: target) ?? -1

            return [lowerBound, upperBound]
        }
    }

    @Test func example1() {
        let nums: [Int] = [5, 7, 7, 8, 8, 10]
        let target: Int = 8
        let expected: [Int] = [3, 4]

        #expect(Solution().searchRange(nums, target) == expected)
    }

    @Test func example2() {
        let nums: [Int] = [5, 7, 7, 8, 8, 10]
        let target: Int = 6
        let expected: [Int] = [-1, -1]

        #expect(Solution().searchRange(nums, target) == expected)
    }

    @Test func example3() {
        let nums: [Int] = []
        let target: Int = 0
        let expected: [Int] = [-1, -1]

        #expect(Solution().searchRange(nums, target) == expected)
    }

}
