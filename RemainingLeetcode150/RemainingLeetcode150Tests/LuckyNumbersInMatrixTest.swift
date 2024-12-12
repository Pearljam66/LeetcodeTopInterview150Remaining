//
//  LuckyNumbersInMatrixTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/12/24.
//

/*
 Given an m x n matrix of distinct numbers, return all lucky numbers in the matrix in any order.
 A lucky number is an element of the matrix such that it is the minimum element in its row and maximum in its column.

 Example 1:
 Input: matrix = [[3,7,8],[9,11,13],[15,16,17]]
 Output: [15]
 Explanation: 15 is the only lucky number since it is the minimum in its row and the maximum in its column.

 Example 2:
 Input: matrix = [[1,10,4,2],[9,3,8,7],[15,16,17,12]]
 Output: [12]
 Explanation: 12 is the only lucky number since it is the minimum in its row and the maximum in its column.

 Example 3:
 Input: matrix = [[7,8],[1,2]]
 Output: [7]
 Explanation: 7 is the only lucky number since it is the minimum in its row and the maximum in its column.

 Constraints:
 m == mat.length
 n == mat[i].length
 1 <= n, m <= 50
 1 <= matrix[i][j] <= 105.
 All elements in the matrix are distinct.
 */

import Testing

struct LuckyNumbersInMatrixTest {

    class Solution {
        func luckyNumbers (_ matrix: [[Int]]) -> [Int] {
            var result = [Int]()

            for i in 0..<matrix.count {
                // Find the minimum in the current row
                let rowMin = matrix[i].min()!
                let minIndex = matrix[i].firstIndex(of: rowMin)!

                // Check if this minimum is also the maximum in its column
                if matrix.allSatisfy({ $0[minIndex] <= rowMin }) {
                    result.append(rowMin)
                }
            }

            return result
        }
    }

    @Test func example1() {
        let solution = Solution()
        #expect(solution.luckyNumbers([[3, 7, 8], [9, 11, 13], [15, 16, 17]]) == [15])
    }

    @Test func example2() {
        let solution = Solution()
        #expect(solution.luckyNumbers([[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]]) == [12])
    }

    @Test func example3() {
        let solution = Solution()
        #expect(solution.luckyNumbers([[7, 8], [1, 2]]) == [7])
    }

}
