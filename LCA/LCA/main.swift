//
//  main.swift
//  LCA
//
//  Created by 桑染 on 2020-02-25.
//  Copyright © 2020 Rick. All rights reserved.
//

import Foundation


func LowestCommonAncestor() {

    let n = Int(readLine()!)!
    var adjList = [[Int]](repeating: [], count: n + 1)
    
    for _ in 0..<n - 1 {
        let edge = readLine()!.split(separator: " ")
        let u = Int(edge[0])!
        let v = Int(edge[1])!
        adjList[u].append(v)
        adjList[v].append(u) // undirected graph
    }
    
    let m = Int(readLine()!)!
    var compair = [[Int]]()

    for _ in 0..<m {
        let pairs = readLine()!.split(separator: " ")
        let num1 = Int(pairs[0])!
        let num2 = Int(pairs[1])!
        compair.append([num1, num2])
    }
    
    // BFS - Queue O(V + E)
    var visited = [Bool](repeating: false, count: n + 1)
    var depth = [Int](repeating: 0, count: n + 1)
    var parent = [Int](repeating: 0, count: n + 1)
    let queue = Queue<Int>()
    queue.enqueue(item: 1) // starting from vertex 1
    visited[1] = true
    depth[1] = 1
    
    while !queue.isEmpty() {
        let first = queue.dequeue()!
        for v in adjList[first] {
            if !visited[v] {
                queue.enqueue(item: v)
                parent[v] = first
                depth[v] = depth[first] + 1
                visited[v] = true
            }
        }
    }
    
    func findParent(_ num: [Int]) {
        let num1 = num[0]
        let num2 = num[1]
        if num1 == num2 {
            print(num1)
        } else if parent[num1] == parent[num2] {
            print(parent[num1])
        } else {
            findParent([parent[num1], parent[num2]])
        }
    }
    
    func findDepth(_ num1: inout Int, _ num2: inout Int) -> [Int] {
        var result = [Int]()
        while depth[num1] != depth[num2] {
            if depth[num1] > depth[num2] {
                num1 = parent[num1]
            } else {
                num2 = parent[num2]
            }
        }
        result.append(num1)
        result.append(num2)
        return result
    }
    
    for i in 0..<m {
        var num1 = compair[i][0]
        var num2 = compair[i][1]
        findParent(findDepth(&num1, &num2))
    }
}


