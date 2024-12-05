//
//  ReverseNodesInKGroupTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/4/24.
//

/*
 Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.
 k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes, in the end, should remain as it is.
 You may not alter the values in the list's nodes, only nodes themselves may be changed.

 Example 1:
 Input: head = [1,2,3,4,5], k = 2
 Output: [2,1,4,3,5]

 Example 2:
 Input: head = [1,2,3,4,5], k = 3
 Output: [3,2,1,4,5]

 Constraints:
 The number of nodes in the list is n.
 1 <= k <= n <= 5000
 0 <= Node.val <= 1000
 */

import Testing

struct ReverseNodesInKGroupTest {

    class ListNode {
        var val: Int
        var next: ListNode?

        init() { self.val = 0; self.next = nil; }
        init(_ val: Int) { self.val = val; self.next = nil; }
        init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }

    class Solution {
        func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
            // Dummy node acts as the prev of the first node of the list
            let dummy = ListNode(0)
            dummy.next = head

            // 'prev' tracks the end of the previous group
            var prev: ListNode? = dummy

            while true {
                var kth: ListNode? = prev

                // Find the kth node from the current group
                for _ in 0..<k {
                    if kth?.next == nil {
                        // If we've reached the end of the list, no more groups to reverse
                        return dummy.next
                    }
                    kth = kth?.next
                }

                // 'start' is the first node of the current group
                let start = prev?.next
                // 'next' is the node after the kth node
                let next = kth?.next

                // Reverse k nodes
                var current = start
                var prevInGroup = next
                while current !== next {
                    let nextNode = current?.next
                    current?.next = prevInGroup
                    prevInGroup = current
                    current = nextNode
                }

                // Connect the reversed group with the rest of the list
                let temp = prev?.next
                prev?.next = prevInGroup
                start?.next = next

                // Move prev to the end of the reversed group
                prev = temp
            }

            return dummy.next
        }
    }

    @Test func example1() {
        let solution = Solution()
        let head = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5)))))
        let result = solution.reverseKGroup(head, 2)

        #expect(result?.val == 2 && result?.next?.val == 1 && result?.next?.next?.val == 4 && result?.next?.next?.next?.val == 3 && result?.next?.next?.next?.next?.val == 5)
    }

    @Test func example2() {
        let solution = Solution()
        let head = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5)))))
        let result = solution.reverseKGroup(head, 3)

        #expect(result?.val == 3 && result?.next?.val == 2 && result?.next?.next?.val == 1 && result?.next?.next?.next?.val == 4 && result?.next?.next?.next?.next?.val == 5)
    }
}
