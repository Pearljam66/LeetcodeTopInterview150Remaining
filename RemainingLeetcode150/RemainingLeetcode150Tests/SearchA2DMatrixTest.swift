//
//  SearchA2DMatrixTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/6/24.
//

/*
 You are given an m x n integer matrix matrix with the following two properties:
 Each row is sorted in non-decreasing order.
 The first integer of each row is greater than the last integer of the previous row.
 Given an integer target, return true if target is in matrix or false otherwise.
 You must write a solution in O(log(m * n)) time complexity.

 Example 1:
 Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
 Output: true

 Example 2:
 Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
 Output: false

 Constraints:
 m == matrix.length
 n == matrix[i].length
 1 <= m, n <= 100
 -104 <= matrix[i][j], target <= 104
 */

import Testing

struct SearchA2DMatrixTest {

    class Solution {
        func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
            if matrix.isEmpty || matrix[0].isEmpty {
                return false
            }

            let rows = matrix.count
            let cols = matrix[0].count
            var left = 0
            var right = rows * cols - 1

            while left <= right {
                let mid = left + (right - left) / 2
                let row = mid / cols
                let col = mid % cols

                if matrix[row][col] == target {
                    return true
                } else if matrix[row][col] < target {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }

            return false
        }
    }

    @Test func example1() {
        #expect(Solution().searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3) == true)
    }

    @Test func example2() {
        #expect(Solution().searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13) == false)
    }

}
