//
//  RemoveNthNodeFromEndListTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/5/24.
//

/*
 Given the head of a linked list, remove the nth node from the end of the list and return its head.

 Example 1:
 Input: head = [1,2,3,4,5], n = 2
 Output: [1,2,3,5]

 Example 2:
 Input: head = [1], n = 1
 Output: []

 Example 3:
 Input: head = [1,2], n = 1
 Output: [1]

 Constraints:
 The number of nodes in the list is sz.
 1 <= sz <= 30
 0 <= Node.val <= 100
 1 <= n <= sz
 */

import Testing

struct RemoveNthNodeFromEndListTest {

    class ListNode {
        var val: Int
        var next: ListNode?

        init() {
            self.val = 0
            self.next = nil
        }

        init (_ val: Int) {
            self.val = val
            self.next = nil
        }

        init (_ val: Int, _ next: ListNode?) {
            self.val = val
            self.next = next
        }

        func convertListNodeToArray(_ head: ListNode?) -> [Int] {
            var result: [Int] = []
            var currentNode = head

            while currentNode != nil {
                result.append(currentNode!.val)
                currentNode = currentNode!.next
            }
            return result
        }
    }

    class Solution {

        // n is the nth node that gets removed from the end of the list
        // head is integers in the linked list, starting from the beginning
        func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
            let dummy = ListNode(0, head)
            var fast: ListNode? = dummy
            var slow: ListNode? = dummy

            for _ in 0..<n {
                fast = fast?.next
                if fast == nil {
                    return dummy.next
                }
            }

            while fast?.next != nil {
                fast = fast?.next
                slow = slow?.next
            }

            slow?.next = slow?.next?.next

            return dummy.next
        }
    }

    @Test("Input: head = [1,2,3,4,5], n = 2, Output: [1,2,3,5]") func example1() {
        let solution = Solution()
        let listNode = ListNode()
        listNode.val = 1
        listNode.next = ListNode(2)
        listNode.next?.next = ListNode(3)
        listNode.next?.next?.next = ListNode(4)
        listNode.next?.next?.next?.next = ListNode(5)
        let n = 2
        let output = [1,2,3,5]
        let nodeRemovedResult = solution.removeNthFromEnd(listNode, n)

        #expect(listNode.convertListNodeToArray(nodeRemovedResult) == output)
    }

    @Test("Input: head = [1], n = 1, Output: []") func example2() {
        let solution = Solution()
        let listNode = ListNode()
        listNode.val = 1
        let n = 1
        let output: [Int] = []
        let nodeRemovedResult = solution.removeNthFromEnd(listNode, n)

        #expect(listNode.convertListNodeToArray(nodeRemovedResult) == output)
    }

    @Test("Input: head = [1,2], n = 1, Output: [1]") func example3() {
        let solution = Solution()
        let listNode = ListNode()
        listNode.val = 1
        listNode.next = ListNode(2)
        let n = 1
        let output: [Int] = [1]
        let nodeRemovedResult = solution.removeNthFromEnd(listNode, n)

        #expect(listNode.convertListNodeToArray(nodeRemovedResult) == output)
    }

}
