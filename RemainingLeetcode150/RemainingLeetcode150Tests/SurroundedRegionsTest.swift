//
//  SurroundedRegionsTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/7/24.
//

/*
 You are given an m x n matrix board containing letters 'X' and 'O', capture regions that are surrounded:
 Connect: A cell is connected to adjacent cells horizontally or vertically.
 Region: To form a region connect every 'O' cell.
 Surround: The region is surrounded with 'X' cells if you can connect the region with 'X' cells and none of the region cells are on the edge of the board.
 A surrounded region is captured by replacing all 'O's with 'X's in the input matrix board.

 Example 1:
 Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
 Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
 Explanation:
 In the above diagram, the bottom region is not captured because it is on the edge of the board and cannot be surrounded.

 Example 2:
 Input: board = [["X"]]
 Output: [["X"]]

 Constraints:
 m == board.length
 n == board[i].length
 1 <= m, n <= 200
 board[i][j] is 'X' or 'O'.
 */

import Testing

struct SurroundedRegionsTest {

    class Solution {
        func solve(_ board: inout [[Character]]) {
            if board.isEmpty || board[0].isEmpty { return }

            let m = board.count
            let n = board[0].count

            // First pass: mark 'O's on the border and their connected 'O's with 'E'
            for i in 0..<m {
                if board[i][0] == "O" { dfs(&board, i, 0) }
                if board[i][n-1] == "O" { dfs(&board, i, n-1) }
            }
            for j in 0..<n {
                if board[0][j] == "O" { dfs(&board, 0, j) }
                if board[m-1][j] == "O" { dfs(&board, m-1, j) }
            }

            // Second pass: convert 'O' to 'X' and 'E' back to 'O'
            for i in 0..<m {
                for j in 0..<n {
                    if board[i][j] == "O" {
                        board[i][j] = "X"
                    } else if board[i][j] == "E" {
                        board[i][j] = "O"
                    }
                }
            }
        }

        private func dfs(_ board: inout [[Character]], _ i: Int, _ j: Int) {
            if i < 0 || i >= board.count || j < 0 || j >= board[0].count || board[i][j] != "O" {
                return
            }
            board[i][j] = "E"  // Mark 'O' as 'E' (escape)
            dfs(&board, i + 1, j)
            dfs(&board, i - 1, j)
            dfs(&board, i, j + 1)
            dfs(&board, i, j - 1)
        }
    }

    @Test func example1() {
        var board: [[Character]] = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
        Solution().solve(&board)
        #expect(board == [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]])
    }

    @Test func example2() {
        var board: [[Character]] = [["X"]]
        Solution().solve(&board)
        #expect(board == [["X"]])
    }

}
