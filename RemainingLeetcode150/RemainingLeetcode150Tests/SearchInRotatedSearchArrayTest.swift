//
//  SearchInRotatedSearchArrayTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/6/24.
//

/*
 There is an integer array nums sorted in ascending order (with distinct values).
 Prior to being passed to your function, nums is possibly rotated at an unknown pivot index k (1 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].
 Given the array nums after the possible rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.
 You must write an algorithm with O(log n) runtime complexity.

 Example 1:
 Input: nums = [4,5,6,7,0,1,2], target = 0
 Output: 4

 Example 2:
 Input: nums = [4,5,6,7,0,1,2], target = 3
 Output: -1

 Example 3:
 Input: nums = [1], target = 0
 Output: -1

 Constraints:
 1 <= nums.length <= 5000
 -104 <= nums[i] <= 104
 All values of nums are unique.
 nums is an ascending array that is possibly rotated.
 -104 <= target <= 104
 */

import Testing

struct SearchInRotatedSearchArrayTest {

    class Solution {
        func search(_ nums: [Int], _ target: Int) -> Int {
            var left = 0
            var right = nums.count - 1

            while left <= right {
                let mid = left + (right - left) / 2

                if nums[mid] == target {
                    return mid
                }

                // If the left part is sorted
                if nums[left] <= nums[mid] {
                    if nums[left] <= target && target < nums[mid] {
                        right = mid - 1
                    } else {
                        left = mid + 1
                    }
                }
                // If the right part is sorted
                else {
                    if nums[mid] < target && target <= nums[right] {
                        left = mid + 1
                    } else {
                        right = mid - 1
                    }
                }
            }

            return -1
        }
    }

    @Test func example1() {
        let nums: [Int] = [4, 5, 6, 7, 0, 1, 2]
        let target: Int = 0
        let expected: Int = 4

        #expect(Solution().search(nums, target) == expected)
    }

    @Test func example2() {
        let nums: [Int] = [4, 5, 6, 7, 0, 1, 2]
        let target: Int = 3
        let expected: Int = -1

        #expect(Solution().search(nums, target) == expected)
    }

    @Test func example3() {
        let nums: [Int] = [1]
        let target: Int = 0
        let expected: Int = -1

        #expect(Solution().search(nums, target) == expected)
    }

}
