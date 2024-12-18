//
//  SortArrayTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/17/24.
//

/*
 Given an array of integers nums, sort the array in ascending order and return it.
 You must solve the problem without using any built-in functions in O(nlog(n)) time complexity and with the smallest space complexity possible.

 Example 1:
 Input: nums = [5,2,3,1]
 Output: [1,2,3,5]
 Explanation: After sorting the array, the positions of some numbers are not changed (for example, 2 and 3), while the positions of other numbers are changed (for example, 1 and 5).

 Example 2:
 Input: nums = [5,1,1,2,0,0]
 Output: [0,0,1,1,2,5]
 Explanation: Note that the values of nums are not necessairly unique.

 Constraints:
 1 <= nums.length <= 5 * 104
 -5 * 104 <= nums[i] <= 5 * 104
 */

import Testing

struct SortArrayTest {

    class Solution {
        func sortArray(_ nums: [Int]) -> [Int] {
            // Base case: if the array has 1 or fewer elements, it's already sorted
            if nums.count <= 1 {
                return nums
            }

            // Divide the array into two halves
            let mid = nums.count / 2
            let left = Array(nums[..<mid])
            let right = Array(nums[mid...])

            // Recursively sort both halves
            return merge(sortArray(left), sortArray(right))
        }

        // Helper function to merge two sorted arrays
        func merge(_ left: [Int], _ right: [Int]) -> [Int] {
            var result = [Int]()
            var leftIndex = 0
            var rightIndex = 0

            // Compare elements from both arrays and merge them in sorted order
            while leftIndex < left.count && rightIndex < right.count {
                if left[leftIndex] <= right[rightIndex] {
                    result.append(left[leftIndex])
                    leftIndex += 1
                } else {
                    result.append(right[rightIndex])
                    rightIndex += 1
                }
            }

            // If there are any remaining elements in left array, append them
            while leftIndex < left.count {
                result.append(left[leftIndex])
                leftIndex += 1
            }

            // If there are any remaining elements in right array, append them
            while rightIndex < right.count {
                result.append(right[rightIndex])
                rightIndex += 1
            }

            return result
        }
    }

    @Test func example1() {
        #expect(Solution().sortArray([5, 2, 3, 1]) == [1, 2, 3, 5])
    }

    @Test func example2() {
        #expect(Solution().sortArray([5, 1, 1, 2, 0, 0]) == [0, 0, 1, 1, 2, 5])
    }

}
