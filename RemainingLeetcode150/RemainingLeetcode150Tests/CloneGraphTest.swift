//
//  CloneGraphTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/7/24.
//

/*
 Given a reference of a node in a connected undirected graph.
 Return a deep copy (clone) of the graph.
 Each node in the graph contains a value (int) and a list (List[Node]) of its neighbors.

 class Node {
 public int val;
 public List<Node> neighbors;
 }

 Test case format:
 For simplicity, each node's value is the same as the node's index (1-indexed). For example, the first node with val == 1, the second node with val == 2, and so on. The graph is represented in the test case using an adjacency list.
 An adjacency list is a collection of unordered lists used to represent a finite graph. Each list describes the set of neighbors of a node in the graph.
 The given node will always be the first node with val = 1. You must return the copy of the given node as a reference to the cloned graph.

 Example 1:
 Input: adjList = [[2,4],[1,3],[2,4],[1,3]]
 Output: [[2,4],[1,3],[2,4],[1,3]]
 Explanation: There are 4 nodes in the graph.
 1st node (val = 1)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
 2nd node (val = 2)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
 3rd node (val = 3)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
 4th node (val = 4)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).

 Example 2:
 Input: adjList = [[]]
 Output: [[]]
 Explanation: Note that the input contains one empty list. The graph consists of only one node with val = 1 and it does not have any neighbors.

 Example 3:
 Input: adjList = []
 Output: []
 Explanation: This an empty graph, it does not have any nodes.

Constraints:
 The number of nodes in the graph is in the range [0, 100].
 1 <= Node.val <= 100
 Node.val is unique for each node.
 There are no repeated edges and no self-loops in the graph.
 The Graph is connected and all nodes can be visited starting from the given node.
 */

// TODO: Need to fix
/*
import Testing

struct CloneGraphTest {

    public class Node {
        public var val: Int
        public var neighbors: [Node?]
        public init(_ val: Int) {
            self.val = val
            self.neighbors = []
        }
    }

    class Solution {
        func cloneGraph(_ node: Node?) -> Node? {
            guard let node = node else { return nil }

            var visited = [Int: Node]()

            func dfs(_ node: Node) -> Node {
                if let existingClone = visited[node.val] {
                    return existingClone
                }

                let clone = Node(node.val)
                visited[node.val] = clone

                for neighbor in node.neighbors {
                    if let neighbor = neighbor {
                        let clonedNeighbor = dfs(neighbor)
                        clone.neighbors.append(clonedNeighbor)
                        // Since the graph is undirected, ensure both directions are cloned
                        if !clonedNeighbor.neighbors.contains(where: { $0?.val == clone.val }) {
                            clonedNeighbor.neighbors.append(clone)
                        }
                    }
                }

                return clone
            }

            return dfs(node)
        }
    }

    // Helper function to create a graph from adjacency list
    private func createGraph(_ adjList: [[Int]]) -> Node? {
        guard !adjList.isEmpty else { return nil }

        let nodes = (1...adjList.count).map { Node($0) }
        for (i, neighbors) in adjList.enumerated() {
            for neighbor in neighbors where neighbor > 0 && neighbor <= nodes.count {
                nodes[i].neighbors.append(nodes[neighbor - 1])
                // Since graph is undirected, add back link
                nodes[neighbor - 1].neighbors.append(nodes[i])
            }
        }

        return nodes[0] // Return the first node, which corresponds to node with val == 1
    }

    // Helper function to convert graph back to adjacency list for testing
    private func graphToAdjList(_ node: Node?) -> [[Int]] {
        var result: [[Int]] = []
        var queue: [Node?] = []
        var visited = Set<Int>()

        if let node = node {
            queue.append(node)
            visited.insert(node.val)

            while !queue.isEmpty {
                if let current = queue.removeFirst() {
                    var neighborsList: [Int] = []
                    for neighbor in current.neighbors {
                        if let neighbor = neighbor, !visited.contains(neighbor.val) {
                            queue.append(neighbor)
                            visited.insert(neighbor.val)
                            neighborsList.append(neighbor.val)
                        }
                    }
                    result.append(neighborsList.sorted()) // Sort neighbors for consistent order
                }
            }
        }

        // Sorting the entire result for consistent order
        return result.sorted { ($0.first ?? Int.max) < ($1.first ?? Int.max) }
    }

    // Test case
    @Test func example1() {
        let input: [[Int]] = [[2, 4], [1, 3], [2, 4], [1, 3]]
        let graph = createGraph(input)
        let clonedGraph = Solution().cloneGraph(graph)
        let output = graphToAdjList(clonedGraph)
        #expect(output == input.sorted { ($0.first ?? Int.max) < ($1.first ?? Int.max) })
    }

    @Test func example2() {
        let input: [[Int]] = []
        let graph = createGraph(input)
        let clonedGraph = Solution().cloneGraph(graph)
        let result = graphToAdjList(clonedGraph)
        #expect(result == input)
    }

    @Test func example3() {
        let input: [[Int]] = []
        let graph = createGraph(input)
        let clonedGraph = Solution().cloneGraph(graph)
        let result = graphToAdjList(clonedGraph)
        #expect(result == input)
    }
}
*/
