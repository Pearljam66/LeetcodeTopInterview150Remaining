//
//  MedianOfTwoSortedArraysTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/6/24.
//

/*
 Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.
 The overall run time complexity should be O(log (m+n)).

 Example 1:
 Input: nums1 = [1,3], nums2 = [2]
 Output: 2.00000
 Explanation: merged array = [1,2,3] and median is 2.

 Example 2:
 Input: nums1 = [1,2], nums2 = [3,4]
 Output: 2.50000
 Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.

 Constraints:
 nums1.length == m
 nums2.length == n
 0 <= m <= 1000
 0 <= n <= 1000
 1 <= m + n <= 2000
 -106 <= nums1[i], nums2[i] <= 106
 */

import Testing

struct MedianOfTwoSortedArraysTest {

    class Solution {
        func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
            let mergedArray = nums1 + nums2
            let sortedArray = mergedArray.sorted()
            if sortedArray.count.isMultiple(of: 2) {
                return Double(sortedArray[sortedArray.count / 2 - 1] + sortedArray[sortedArray.count / 2]) / 2
            } else {
                let index = sortedArray.count / 2
                return Double(sortedArray[index])
            }
        }
    }

    @Test func example1() {
        #expect(Solution().findMedianSortedArrays([1, 3], [2]) == 2)
    }

    @Test func example2() {
        #expect(Solution().findMedianSortedArrays([1, 2], [3, 4]) == 2.5)
    }
}
