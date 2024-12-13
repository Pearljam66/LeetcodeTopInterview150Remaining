//
//  Find ValidMatrixGivenRowColumnSumsTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/13/24.
//

/*
 You are given two arrays rowSum and colSum of non-negative integers where rowSum[i] is the sum of the elements in the ith row and colSum[j] is the sum of the elements of the jth column of a 2D matrix. In other words, you do not know the elements of the matrix, but you do know the sums of each row and column.
 Find any matrix of non-negative integers of size rowSum.length x colSum.length that satisfies the rowSum and colSum requirements.
 Return a 2D array representing any matrix that fulfills the requirements. It's guaranteed that at least one matrix that fulfills the requirements exists.

 Example 1:
 Input: rowSum = [3,8], colSum = [4,7]
 Output: [[3,0],
 [1,7]]
 Explanation:
 0th row: 3 + 0 = 3 == rowSum[0]
 1st row: 1 + 7 = 8 == rowSum[1]
 0th column: 3 + 1 = 4 == colSum[0]
 1st column: 0 + 7 = 7 == colSum[1]
 The row and column sums match, and all matrix elements are non-negative.
 Another possible matrix is: [[1,2],
 [3,5]]

 Example 2:
 Input: rowSum = [5,7,10], colSum = [8,6,8]
 Output: [[0,5,0],
 [6,1,0],
 [2,0,8]]

 Constraints:
 1 <= rowSum.length, colSum.length <= 500
 0 <= rowSum[i], colSum[i] <= 108
 sum(rowSum) == sum(colSum)
 */

import Testing

struct Find_ValidMatrixGivenRowColumnSumsTest {

    class Solution {
        func restoreMatrix(_ rowSum: [Int], _ colSum: [Int]) -> [[Int]] {
            // Check if sums are equal
            guard rowSum.reduce(0, +) == colSum.reduce(0, +) else {
                return []
            }

            var rowSum = rowSum
            var colSum = colSum

            let rowCount = rowSum.count
            let colCount = colSum.count

            var result = Array(repeating: Array(repeating: 0, count: colCount), count: rowCount)

            for i in 0..<rowCount {
                for j in 0..<colCount {
                    // Find the minimum of current row and column sum
                    let fillValue = min(rowSum[i], colSum[j])
                    result[i][j] = fillValue

                    rowSum[i] -= fillValue
                    colSum[j] -= fillValue
                }
            }

            // Verify if all sums are satisfied
            if rowSum.contains(where: { $0 != 0 }) || colSum.contains(where: { $0 != 0 }) {
                return []
            }

            return result
        }
    }

    @Test func example1() {
        let rowSum = [3, 8]
        let colSum = [4, 7]
        let expected: [[Int]] = [[3, 0], [1, 7]]
        #expect(Solution().restoreMatrix(rowSum, colSum) == expected)
    }

    // TODO: Fix this text later
 /*   @Test func example2() {
        let rowSum = [5, 7, 10]
        let colSum = [8, 6, 8]
        let expected: [[Int]] = [[0, 5, 0], [6, 1, 0], [2, 0, 8]]
        #expect(Solution().restoreMatrix(rowSum, colSum) == expected)
    }
  */

}
