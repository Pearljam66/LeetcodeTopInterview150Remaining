//
//  BuildMatrixWithConditionsTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/14/24.
//

/*
 You are given a positive integer k. You are also given:
 a 2D integer array rowConditions of size n where rowConditions[i] = [abovei, belowi], and
 a 2D integer array colConditions of size m where colConditions[i] = [lefti, righti].
 The two arrays contain integers from 1 to k.
 You have to build a k x k matrix that contains each of the numbers from 1 to k exactly once. The remaining cells should have the value 0.

 The matrix should also satisfy the following conditions:
 The number abovei should appear in a row that is strictly above the row at which the number belowi appears for all i from 0 to n - 1.
 The number lefti should appear in a column that is strictly left of the column at which the number righti appears for all i from 0 to m - 1.
 Return any matrix that satisfies the conditions. If no answer exists, return an empty matrix.

 Example 1:
 Input: k = 3, rowConditions = [[1,2],[3,2]], colConditions = [[2,1],[3,2]]
 Output: [[3,0,0],[0,0,1],[0,2,0]]
 Explanation: The diagram above shows a valid example of a matrix that satisfies all the conditions.
 The row conditions are the following:
 - Number 1 is in row 1, and number 2 is in row 2, so 1 is above 2 in the matrix.
 - Number 3 is in row 0, and number 2 is in row 2, so 3 is above 2 in the matrix.
 The column conditions are the following:
 - Number 2 is in column 1, and number 1 is in column 2, so 2 is left of 1 in the matrix.
 - Number 3 is in column 0, and number 2 is in column 1, so 3 is left of 2 in the matrix.
 Note that there may be multiple correct answers.

 Example 2:
 Input: k = 3, rowConditions = [[1,2],[2,3],[3,1],[2,3]], colConditions = [[2,1]]
 Output: []
 Explanation: From the first two conditions, 3 has to be below 1 but the third conditions needs 3 to be above 1 to be satisfied.
 No matrix can satisfy all the conditions, so we return the empty matrix.

 Constraints:
 2 <= k <= 400
 1 <= rowConditions.length, colConditions.length <= 104
 rowConditions[i].length == colConditions[i].length == 2
 1 <= abovei, belowi, lefti, righti <= k
 abovei != belowi
 lefti != righti
 */

import Testing

struct BuildMatrixWithConditionsTest {

    class Solution {
        func buildMatrix(_ k: Int, _ rowConditions: [[Int]], _ colConditions: [[Int]]) -> [[Int]] {
            func topologicalSort(_ conditions: [[Int]], _ k: Int) -> [Int]? {
                var graph = [Int: [Int]]()
                var inDegree = [Int](repeating: 0, count: k + 1)

                for condition in conditions {
                    let u = condition[0]
                    let v = condition[1]
                    graph[u, default: []].append(v)
                    inDegree[v] += 1
                }

                var queue = [Int]()
                for i in 1...k {
                    if inDegree[i] == 0 {
                        queue.append(i)
                    }
                }

                var order = [Int]()
                while !queue.isEmpty {
                    let node = queue.removeFirst()
                    order.append(node)
                    if let neighbors = graph[node] {
                        for neighbor in neighbors {
                            inDegree[neighbor] -= 1
                            if inDegree[neighbor] == 0 {
                                queue.append(neighbor)
                            }
                        }
                    }
                }

                return order.count == k ? order : nil
            }

            guard let rowOrder = topologicalSort(rowConditions, k),
                  let colOrder = topologicalSort(colConditions, k) else {
                return []
            }

            // Create a k x k matrix filled with zeros
            var matrix = Array(repeating: Array(repeating: 0, count: k), count: k)

            // Assign numbers their row and column positions
            var positionInRow = [Int: Int]()
            var positionInCol = [Int: Int]()

            // Determine the row positions based on rowOrder
            for (index, num) in rowOrder.enumerated() {
                positionInRow[num] = index
            }

            // Determine the column positions based on colOrder
            for (index, num) in colOrder.enumerated() {
                positionInCol[num] = index
            }

            for num in 1...k {
                if let row = positionInRow[num], let col = positionInCol[num] {
                    matrix[row][col] = num
                }
            }

            return matrix
        }
    }

    @Test func example1() {
        let solution = Solution()
       // [[3,0,0],[0,0,1],[0,2,0]]
        #expect(solution.buildMatrix(3, [[1, 2], [3, 2]], [[2, 1], [3, 2]]) == [[0,0,1],[3,0,0],[0,2,0]])
    }

    @Test func example2() {
        let solution = Solution()
        #expect(solution.buildMatrix(3, [[1, 2], [2, 3], [3, 1], [2, 3]], [[2, 1]]) == [])
    }

}
