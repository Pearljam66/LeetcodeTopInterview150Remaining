//
//  NumberOfIslandsTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/7/24.
//

/*
 Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.
 An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

 Example 1:
 Input: grid = [
 ["1","1","1","1","0"],
 ["1","1","0","1","0"],
 ["1","1","0","0","0"],
 ["0","0","0","0","0"]
 ]
 Output: 1

 Example 2:
 Input: grid = [
 ["1","1","0","0","0"],
 ["1","1","0","0","0"],
 ["0","0","1","0","0"],
 ["0","0","0","1","1"]
 ]
 Output: 3


 Constraints:
 m == grid.length
 n == grid[i].length
 1 <= m, n <= 300
 grid[i][j] is '0' or '1'.
 */

import Testing

struct NumberOfIslandsTest {

    class Solution {
        func numIslands(_ grid: [[Character]]) -> Int {
            guard !grid.isEmpty else { return 0 }

            var grid = grid // Make a mutable copy of the grid
            var count = 0

            for i in 0..<grid.count {
                for j in 0..<grid[i].count {
                    if grid[i][j] == "1" {
                        count += 1
                        dfs(&grid, i, j)
                    }
                }
            }

            return count
        }

        private func dfs(_ grid: inout [[Character]], _ i: Int, _ j: Int) {
            if i < 0 || i >= grid.count || j < 0 || j >= grid[i].count || grid[i][j] == "0" {
                return
            }

            grid[i][j] = "0" // Mark as visited

            // Explore all four directions
            dfs(&grid, i - 1, j) // Up
            dfs(&grid, i + 1, j) // Down
            dfs(&grid, i, j - 1) // Left
            dfs(&grid, i, j + 1) // Right
        }
    }

    @Test func example1() {
        let grid: [[Character]] = [
            ["1","1","1","1","0"].map { Character($0) },
            ["1","1","0","1","0"].map { Character($0) },
            ["1","1","0","0","0"].map { Character($0) },
            ["0","0","0","0","0"].map { Character($0) }
        ]
        assert(Solution().numIslands(grid) == 1)
    }

    @Test func example2() {
        let grid: [[Character]] = [
            ["1","1","0","0","0"].map { Character($0) },
            ["1","1","0","0","0"].map { Character($0) },
            ["0","0","1","0","0"].map { Character($0) },
            ["0","0","0","1","1"].map { Character($0) }
        ]
        assert(Solution().numIslands(grid) == 3)
    }
}
