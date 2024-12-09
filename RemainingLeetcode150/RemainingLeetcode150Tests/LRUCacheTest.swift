//
//  LRUCacheTest.swift
//  RemainingLeetcode150Tests
//
//  Created by Sarah Clark on 12/8/24.
//

/*
 Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.
 Implement the LRUCache class:
 LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
 int get(int key) Return the value of the key if the key exists, otherwise return -1.
 void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.
 The functions get and put must each run in O(1) average time complexity.

 Example 1:
 Input
 ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
 [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
 Output
 [null, null, null, 1, null, -1, null, -1, 3, 4]

 Explanation
 LRUCache lRUCache = new LRUCache(2);
 lRUCache.put(1, 1); // cache is {1=1}
 lRUCache.put(2, 2); // cache is {1=1, 2=2}
 lRUCache.get(1);    // return 1
 lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
 lRUCache.get(2);    // returns -1 (not found)
 lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
 lRUCache.get(1);    // return -1 (not found)
 lRUCache.get(3);    // return 3
 lRUCache.get(4);    // return 4

 Constraints:
 1 <= capacity <= 3000
 0 <= key <= 104
 0 <= value <= 105
 At most 2 * 105 calls will be made to get and put.
 */

import Testing

struct LRUCacheTest {


    class LRUCache {
        // Node class for doubly linked list
        class Node {
            var key: Int
            var value: Int
            var prev: Node?
            var next: Node?

            init(_ key: Int, _ value: Int) {
                self.key = key
                self.value = value
            }
        }

        // Properties
        private var capacity: Int
        private var cache: [Int: Node]
        private var head: Node
        private var tail: Node

        // Initialize the cache
        init(_ capacity: Int) {
            self.capacity = capacity
            self.cache = [:]

            // Create dummy head and tail nodes
            head = Node(0, 0)
            tail = Node(0, 0)
            head.next = tail
            tail.prev = head
        }

        // Get value for a key
        func get(_ key: Int) -> Int {
            // Check if key exists in cache
            guard let node = cache[key] else {
                return -1
            }

            // Move the accessed node to the front (most recently used)
            moveToHead(node)

            return node.value
        }

        // Put a key-value pair in the cache
        func put(_ key: Int, _ value: Int) {
            // If key already exists, update value and move to front
            if let existingNode = cache[key] {
                existingNode.value = value
                moveToHead(existingNode)
                return
            }

            // Create new node
            let newNode = Node(key, value)

            // Add to cache and move to front
            cache[key] = newNode
            addToHead(newNode)

            // If cache exceeds capacity, remove least recently used
            if cache.count > capacity {
                if let tailPrev = tail.prev, tailPrev !== head {
                    removeNode(tailPrev)
                    cache.removeValue(forKey: tailPrev.key)
                }
            }
        }

        // Helper method to add node to head (most recently used)
        private func addToHead(_ node: Node) {
            node.prev = head
            node.next = head.next
            head.next?.prev = node
            head.next = node
        }

        // Helper method to move existing node to head
        private func moveToHead(_ node: Node) {
            // Remove node from current position
            removeNode(node)

            // Add to head
            addToHead(node)
        }

        // Helper method to remove a node from the list
        private func removeNode(_ node: Node) {
            node.prev?.next = node.next
            node.next?.prev = node.prev
        }
    }

    @Test func example1() {
        let lRUCache = LRUCache(2);
        lRUCache.put(1, 1)
        lRUCache.put(2, 2)
        #expect(lRUCache.get(1) == 1)
        lRUCache.put(3, 3)
        #expect(lRUCache.get(2) == -1)
        lRUCache.put(4, 4)
        #expect(lRUCache.get(1) == -1)
        #expect(lRUCache.get(3) == 3)
        #expect(lRUCache.get(4) == 4)
    }

}
