//
//  SearchInsertPositionTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/6/24.
//

/*
 Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
 You must write an algorithm with O(log n) runtime complexity.

 Example 1:
 Input: nums = [1,3,5,6], target = 5
 Output: 2

 Example 2:
 Input: nums = [1,3,5,6], target = 2
 Output: 1

 Example 3:
 Input: nums = [1,3,5,6], target = 7
 Output: 4

 Constraints:
 1 <= nums.length <= 104
 -104 <= nums[i] <= 104
 nums contains distinct values sorted in ascending order.
 -104 <= target <= 104
 */

import Testing

struct SearchInsertPositionTest {

     class Solution {
         func searchInsert(_ nums: [Int], _ target: Int) -> Int {
             var left = 0
             var right = nums.count - 1

             while left <= right {
                 // Avoid overflow by using this method to find the midpoint
                 let mid = left + (right - left) / 2

                 if nums[mid] == target {
                     return mid
                 } else if nums[mid] < target {
                     left = mid + 1
                 } else {
                     right = mid - 1
                 }
             }

             // If we've exited the loop, 'left' is where the target should be inserted
             return left
         }
     }

    @Test func example1() {
        let solution = Solution()
        let nums: [Int] = [1,3,5,6]
        let target: Int = 5
        let expected: Int = 2

        #expect(solution.searchInsert(nums, target) == expected)
    }

    @Test func example2() {
        let solution = Solution()
        let nums: [Int] = [1,3,5,6]
        let target: Int = 2
        let expected: Int = 1

        #expect(solution.searchInsert(nums, target) == expected)
    }

    @Test func example3() {
        let solution = Solution()
        let nums: [Int] = [1,3,5,6]
        let target: Int = 7
        let expected: Int = 4

        #expect(solution.searchInsert(nums, target) == expected)
    }

}
