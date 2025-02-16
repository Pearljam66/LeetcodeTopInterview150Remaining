//
//  FindTheCityTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/21/24.
//

/*
 There are n cities numbered from 0 to n-1. Given the array edges where edges[i] = [fromi, toi, weighti] represents a bidirectional and weighted edge between cities fromi and toi, and given the integer distanceThreshold.
 Return the city with the smallest number of cities that are reachable through some path and whose distance is at most distanceThreshold, If there are multiple such cities, return the city with the greatest number.
 Notice that the distance of a path connecting cities i and j is equal to the sum of the edges' weights along that path.

 Example 1:
 Input: n = 4, edges = [[0,1,3],[1,2,1],[1,3,4],[2,3,1]], distanceThreshold = 4
 Output: 3
 Explanation: The figure above describes the graph.
 The neighboring cities at a distanceThreshold = 4 for each city are:
 City 0 -> [City 1, City 2]
 City 1 -> [City 0, City 2, City 3]
 City 2 -> [City 0, City 1, City 3]
 City 3 -> [City 1, City 2]
 Cities 0 and 3 have 2 neighboring cities at a distanceThreshold = 4, but we have to return city 3 since it has the greatest number.

 Example 2:
 Input: n = 5, edges = [[0,1,2],[0,4,8],[1,2,3],[1,4,2],[2,3,1],[3,4,1]], distanceThreshold = 2
 Output: 0
 Explanation: The figure above describes the graph.
 The neighboring cities at a distanceThreshold = 2 for each city are:
 City 0 -> [City 1]
 City 1 -> [City 0, City 4]
 City 2 -> [City 3, City 4]
 City 3 -> [City 2, City 4]
 City 4 -> [City 1, City 2, City 3]
 The city 0 has 1 neighboring city at a distanceThreshold = 2.

 Constraints:
 2 <= n <= 100
 1 <= edges.length <= n * (n - 1) / 2
 edges[i].length == 3
 0 <= fromi < toi < n
 1 <= weighti, distanceThreshold <= 10^4
 All pairs (fromi, toi) are distinct.
 */

import Testing

struct FindTheCityTest {

    class Solution {
        func findTheCity(_ n: Int, _ edges: [[Int]], _ distanceThreshold: Int) -> Int {
            // Initialize distance matrix with max values
            var dist = Array(repeating: Array(repeating: Int.max / 2, count: n), count: n)

            // Set diagonal to 0
            for i in 0..<n {
                dist[i][i] = 0
            }

            // Populate distance matrix with edge weights
            for edge in edges {
                let from = edge[0]
                let to = edge[1]
                let weight = edge[2]
                dist[from][to] = weight
                dist[to][from] = weight
            }

            // Floyd-Warshall algorithm to find shortest paths
            for k in 0..<n {
                for i in 0..<n {
                    for j in 0..<n {
                        dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])
                    }
                }
            }

            var minReachableCities = Int.max
            var resultCity = -1

            // Find city with minimum number of reachable cities within threshold
            for i in 0..<n {
                var reachableCities = 0
                for j in 0..<n {
                    if i != j && dist[i][j] <= distanceThreshold {
                        reachableCities += 1
                    }
                }

                // If current city has fewer or equal reachable cities,
                // or has the same number but a greater city number
                if reachableCities <= minReachableCities {
                    minReachableCities = reachableCities
                    resultCity = i
                }
            }
            return resultCity
        }
    }

    @Test func example1() {
        #expect(Solution().findTheCity(4, [[0, 1, 3], [1, 2, 1], [1, 3, 4], [2, 3, 1]], 4) == 3)
    }

    @Test func example2() {
        #expect(Solution().findTheCity(5, [[0, 1, 2], [0, 4, 8], [1, 2, 3], [1, 4, 2], [2, 3, 1], [3, 4, 1]], 2) == 0)
    }

}
