//
//  ConstructBinaryTreePreorderInOrderTraversalTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/22/24.
//

/*
 Given two integer arrays preorder and inorder where preorder is the preorder traversal of a binary tree and inorder is the inorder traversal of the same tree, construct and return the binary tree.

 Example 1:
 Input: preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
 Output: [3,9,20,null,null,15,7]

 Example 2:
 Input: preorder = [-1], inorder = [-1]
 Output: [-1]

 Constraints:
 1 <= preorder.length <= 3000
 inorder.length == preorder.length
 -3000 <= preorder[i], inorder[i] <= 3000
 preorder and inorder consist of unique values.
 Each value of inorder also appears in preorder.
 preorder is guaranteed to be the preorder traversal of the tree.
 inorder is guaranteed to be the inorder traversal of the tree.
 */

import Testing

struct ConstructBinaryTreePreorderInOrderTraversalTest {

    class TreeNode {
        var val: Int
        var left: TreeNode?
        var right: TreeNode?

        init() { self.val = 0; self.left = nil; self.right = nil; }
        init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }

    class Solution {
        func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
            // Create a dictionary to store indices of inorder elements
            var inorderIndexMap = [Int: Int]()
            for (index, value) in inorder.enumerated() {
                inorderIndexMap[value] = index
            }

            // Recursive helper function
            func buildTreeHelper(
                preorderStart: Int,
                preorderEnd: Int,
                inorderStart: Int,
                inorderEnd: Int
            ) -> TreeNode? {
                // Base case: no elements to construct
                if preorderStart > preorderEnd || inorderStart > inorderEnd {
                    return nil
                }

                // Root is the first element in preorder
                let rootValue = preorder[preorderStart]
                let root = TreeNode(rootValue)

                // Find root index in inorder array
                guard let rootIndex = inorderIndexMap[rootValue] else {
                    return nil
                }

                // Calculate left subtree size
                let leftSubtreeSize = rootIndex - inorderStart

                // Recursively build left and right subtrees
                root.left = buildTreeHelper(
                    preorderStart: preorderStart + 1,
                    preorderEnd: preorderStart + leftSubtreeSize,
                    inorderStart: inorderStart,
                    inorderEnd: rootIndex - 1
                )

                root.right = buildTreeHelper(
                    preorderStart: preorderStart + leftSubtreeSize + 1,
                    preorderEnd: preorderEnd,
                    inorderStart: rootIndex + 1,
                    inorderEnd: inorderEnd
                )

                return root
            }

            // Call helper function with full range
            return buildTreeHelper(
                preorderStart: 0,
                preorderEnd: preorder.count - 1,
                inorderStart: 0,
                inorderEnd: inorder.count - 1
            )
        }

            // Improved tree to array conversion
            func treeToArray(_ root: TreeNode?) -> [Int?] {
                guard let root = root else { return [] }

                var result = [Int?]()
                var queue = [TreeNode?]()
                queue.append(root)

                while !queue.isEmpty {
                    let levelSize = queue.count
                    var levelHasNodes = false

                    for _ in 0..<levelSize {
                        let node = queue.removeFirst()

                        if let node = node {
                            result.append(node.val)

                            // Check if this node has children
                            if node.left != nil || node.right != nil {
                                levelHasNodes = true
                            }

                            queue.append(node.left)
                            queue.append(node.right)
                        } else {
                            result.append(nil)
                            queue.append(nil)
                            queue.append(nil)
                        }
                    }

                    // Stop if no more nodes in next level
                    if !levelHasNodes {
                        break
                    }
                }

                // Remove trailing nulls
                while result.last == nil {
                    result.removeLast()
                }

                return result
            }
        }

    @Test func example1() {
        let solution = Solution()
        let preorder = [3,9,20,15,7]
        let inorder = [9,3,15,20,7]

        let result = solution.buildTree(preorder, inorder)
        let resultArray = solution.treeToArray(result)

        #expect(resultArray == [3,9,20,nil,nil,15,7])
    }

    @Test func example2() {
        let solution = Solution()
        let preorder = [-1]
        let inorder = [-1]

        let result = solution.buildTree(preorder, inorder)
        let resultArray = solution.treeToArray(result)

        #expect(resultArray == [-1])
    }

}
