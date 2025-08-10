[**Author:** @mdimamhosen, @mahabubulhasibshawon
**Date:** 2025-04-22
**Category:** interview-qa/Higher-Order
**Tags:** [go, First-Order, Higher-Order]
]

## First-Order Function and Higher-Order Function

### First-Order Function

**First-Order Function** এমন একটি function, যা সাধারণ data type (যেমন int, string ইত্যাদি) এর উপর কাজ করে এবং কোনো function কে ইনপুট হিসেবে নেয় না বা return করে না।

### Higher-Order Function

**Higher-Order Function** এমন function, যা অন্য function কে argument হিসেবে নিতে পারে এবং/অথবা function return করতে পারে। Higher-Order Function **functional programming paradigm** এ খুব গুরুত্বপূর্ণ ভূমিকা রাখে।

### Example Code

#### First-Order Function

```go
package main

import "fmt"

// First-order function: does not take or return another function
func add(a int, b int) int {
    return a + b
}

func main() {
    result := add(5, 3)
    fmt.Println("Result:", result) // Output: Result: 8
}
```

#### Higher-Order Function

```go
package main

import "fmt"

// Higher-order function: takes a function as an argument
func applyOperation(a int, b int, operation func(int, int) int) int {
    return operation(a, b)
}

// Function to be passed as an argument
func multiply(a int, b int) int {
    return a * b
}

func main() {
    result := applyOperation(5, 3, multiply)
    fmt.Println("Result:", result) // Output: Result: 15
}
```

### Logic in Mathematics

Discrete Mathmatics-এ, logic ব্যবহার করা হয় object এর property এবং তাদের relation বিশ্লেষণ করার জন্য।

1. **Object**: এমন কিছু যার বাস্তব অস্তিত্ব আছে (যেমন: মানুষ, প্রাণী)
2. **Property**: Object-এর বৈশিষ্ট্য বা গুণ (যেমন: রং, উচ্চতা)
3. **Relation**: কিভাবে object-গুলো একে অপরের সাথে সম্পর্কযুক্ত (যেমন: "all customers must pay their pizza bills")

উদাহরণ:

* **Object**: Customer

* **Property**: Has a bill

* **Relation**: Must pay the bill

* **First-Order Logic**: Object, property এবং relation নিয়ে কাজ করে।

* **Higher-Order Logic**: function এর মধ্যকার relation বা operations নিয়ে কাজ করে।

function এর ক্ষেত্রে:

* **First-Order Function**: সরাসরি object ও তার properties এর উপর কাজ করে।
* **Higher-Order Function**: function এর মধ্যকার relation নিয়ে কাজ করে, যেটা আরও abstract ও flexible operations করতে সাহায্য করে।

### Functional Paradigms

Functional programming এমন একটি programming paradigm যেখানে program গঠন করা হয় function apply এবং compose করার মাধ্যমে। এই paradigm জোর দেওয়া হয় **pure functions**, **immutability**, এবং **higher-order functions** এর উপর।

* **Pure Functions**: একই input সব সময় একই output দেয়, এবং কোনো side effect থাকে না।
* **Immutability**: একবার data তৈরি হলে তা পরিবর্তন করা যায় না; পরিবর্তনের জন্য নতুন data তৈরি করা হয়।
* **First-Class Functions**: function গুলোকে variable এ রাখা যায়, argument হিসেবে পাঠানো যায় এবং অন্য function থেকে return করা যায়।
* **Higher-Order Functions**: functionগুলো অন্য function কে argument হিসেবে নিতে পারে বা return করতে পারে।

**Haskell**, **Racket**, এবং **Lisp** এর মতো functional programming ভাষাগুলো function নিয়ে কাজ করার জন্য শক্তিশালী abstraction দেয়।

### Additional Example Code

#### Higher-Order Function Returning Another Function

```go
package main

import "fmt"

// Higher-order function: returns another function
func call() func(int, int) {
    return add
}

func add(a, b int) {
    z := a + b
    fmt.Println(z)
}

func main() {
    // call() is a higher-order function which returns the function add.
    // The returned function is assigned to a variable f, then f is called with arguments 10, 20.
    f := call()
    f(10, 20) // Output: 30
}
```

#### Higher-Order Function with First-Class Functions

```go
package main

import "fmt"

// Higher-order function: accepts another function as an argument
func applyAndReturn(fn func(int, int) int, x int, y int) int {
    return fn(x, y)
}

// Function to be passed as an argument
func subtract(a int, b int) int {
    return a - b
}

func main() {
    result := applyAndReturn(subtract, 10, 5)
    fmt.Println("Result:", result) // Output: Result: 5
}
```

### Interview Q\&A (Code Examples)

#### 1. **What is a higher-order function?**

**Question**: What is a higher-order function, and how does it work in Go?

**Answer**:
একটি higher-order function এমন function, যেটা অন্য function কে parameter হিসেবে নিতে পারে অথবা অন্য কোনো functionকে return করতে পারে অথবা উভয়ই করতে পারে।

উদাহরণ:

```go
package main

import "fmt"

func applyOperation(a int, b int, operation func(int, int) int) int {
    return operation(a, b)
}

func add(a, b int) int {
    return a + b
}

func main() {
    result := applyOperation(3, 4, add)
    fmt.Println("Result:", result) // Output: Result: 7
}
```

#### 2. **What is a first-order function?**

**Question**: Explain a first-order function in Go.

**Answer**:
একটি first-order function হলো এমন function, যা শুধুমাত্র সাধারন data type নিয়ে কাজ করে এবং অন্য কোনো function কে parameter হিসেবে নেয় না বা return করে না।

উদাহরণ:

```go
package main

import "fmt"

func add(a int, b int) int {
    return a + b
}

func main() {
    result := add(3, 5)
    fmt.Println("Result:", result) // Output: Result: 8
}
```

#### 3. **Can you create a function that returns another function?**

**Question**: Write a function that returns another function and demonstrates its usage.

**Answer**:
হ্যাঁ, একটি higher-order function তৈরি করা যায় যেটা আরেকটি function return করে।

```go
package main

import "fmt"

func multiply(a int) func(int) int {
    return func(b int) int {
        return a * b
    }
}

func main() {
    multiplyBy2 := multiply(2)
    fmt.Println("Result:", multiplyBy2(5)) // Output: Result: 10
}
```

#### 4. **What is an anonymous function in Go?**

**Question**: Show an example of an anonymous function in Go.

**Answer**:
Anonymous function হলো এমন একটি function যার নাম নেই। সাধারণত ছোট বা একবারের জন্য ব্যবহৃত কাজের ক্ষেত্রে এটি ব্যবহৃত হয়।

```go
package main

import "fmt"

func main() {
    func(a int, b int) {
        fmt.Println("Sum:", a+b)
    }(3, 4) // Output: Sum: 7
}
```

#### 5. **What is an Immediately Invoked Function Expression (IIFE) in Go?**

**Question**: Write a code example for an Immediately Invoked Function Expression (IIFE) in Go.

**Answer**:
IIFE এমন একটি function যেটি define করার সাথে সাথেই invoke (call) করা হয়।

```go
package main

import "fmt"

func main() {
    result := func(a int, b int) int {
        return a + b
    }(3, 4)

    fmt.Println("Result:", result) // Output: Result: 7
}
```
