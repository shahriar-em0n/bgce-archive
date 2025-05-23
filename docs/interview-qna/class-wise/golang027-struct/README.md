# ক্লাস ২৭: Go স্ট্রাক্ট এবং মেমোরি বিন্যাস 🧱

এই ক্লাসে আমরা **স্ট্রাক্ট** কীভাবে ডিফাইন ও ইন্সট্যানশিয়েট করতে হয়, এবং এগুলো কীভাবে Go এর মেমোরি মডেলের সাথে কাজ করে তা শিখব। 🧠💡

---

## ✍️ ক্লাস ২৭ এর কোড:

```go
package main

import "fmt"

type User struct {
	Name string
	Age  int
}

func (usr User) printDetails() {
	fmt.Println("Name:", usr.Name)
	fmt.Println("Age:", usr.Age)
}

func main() {
	user1 := User{
		Name: "Ruhin",
		Age:  21,
	}

	user2 := User{
		Name: "Mukim",
		Age:  15,
	}

	user1.printDetails()
	user2.printDetails()
}
```

---

## 🧠 মূল ধারণা

### 🧩 স্ট্রাক্ট (Struct) কী?

Go তে **স্ট্রাক্ট** হলো একটি ইউজার ডিফাইন্ড টাইপ(user-defined type), যা ব্যবহারকারী নিজের মতো করে তৈরি করতে পারে, যাতে সম্পর্কিত ডেটা একসাথে রাখা যায়। এটি মূলত বিভিন্ন ফিল্ডের জন্য একটি কাস্টম কন্টেইনার।

```go
type User struct {
	Name string
	Age  int
}
```

এটি `User` নামে একটি নতুন টাইপ ডিফাইন করে, যার ফিল্ড হলো `Name` এবং `Age`।

---

### 🔨 ইনস্ট্যান্স তৈরি (Instantiation)

যখন আমরা স্ট্রাক্ট টাইপ ব্যবহার করে একটি আসল মান তৈরি করি, সেটাই **ইনস্ট্যান্সিয়েশন (Instantiation)**.।

```go
user1 := User{
	Name: "Ruhin",
	Age:  21,
}
```

এখানে `user1` হলো `User` টাইপের একটি **ইনস্ট্যান্স**। এটি `Name` এবং `Age` মানগুলো রাখার জন্য মেমোরি অ্যালোকেট করে।

---

## 🧠 মেমোরি লেআউট (ভিজ্যুয়ালাইজেশন)

```
┌─────────────────────────────┐
│       কোড সেগমেন্ট         │
│-----------------------------│
│ main, printDetails,         │
│ type User struct {...}      │
└─────────────────────────────┘
          ↓
┌─────────────────────────────┐
│       ডেটা সেগমেন্ট         │
│-----------------------------│
│ -                           │
│(গ্লোবাল ভেরিয়েবল থাকলে)    │
└─────────────────────────────┘
          ↓
┌─────────────────────────────┐
│           স্ট্যাক             │
│-----------------------------│
│ main() frame →              │
│   user1 → Name: "Ruhin"     │
│           Age: 21           │
│   user2 → Name: "Mukim"     │
│           Age: 15           │
└─────────────────────────────┘
```

> ⚠️ NOTE: If a struct is returned from a function or captured by a closure, it may escape to the heap instead of stack.
> ⚠️ নোট: যদি কোনো স্ট্রাক্ট ফাংশন থেকে রিটার্ন হয় বা ক্লোজারে ব্যবহার হয়, তাহলে এটি স্ট্যাকের বদলে হিপে স্থানান্তরিত হতে পারে।

---

## 📋 উদাহরণ

```go
type Book struct {
	Title  string
	Author string
	Pages  int
}

book1 := Book{
	Title: "1984",
	Author: "George Orwell",
	Pages: 328,
}
```

এভাবে আমরা একাধিক তথ্য নিয়ে বাস্তব জীবনের মতো মডেল তৈরি করতে পারি।

---

## 🧹 গারবেজ কালেক্টরের ভূমিকা

- যদি কোনো স্ট্রাক্ট ইনস্ট্যান্স **এস্কেপ** করে (ফাংশনের বাইরে ব্যবহার হয়, দীর্ঘ সময় ধরে রাখা হয়), তাহলে Go সেটি হিপে রাখে।
- Go এর **গারবেজ কালেক্টর** তখন সেটি ট্র্যাক করে আর ব্যবহার না হলে মেমোরি ফাঁকা করে দেয়।
- তাই ম্যানুয়ালি `free()` করার দরকার নেই, Go নিজেই হিপের মেমোরি পরিচ্ছন্ন করে।

---

## 🚀 সংক্ষেপে

- `type User struct {...}` হলো টাইপের তথ্য → কোড সেগমেন্ট-এ থাকে।
- `user1 := User{...}` হলো রানটাইম ডেটা → স্ট্যাক বা হিপের রাখা হয় ব্যবহার অনুযায়ী।
- স্ট্রাক্ট একসাথে অনেক ফিল্ডকে একটি লজিক্যাল ইউনিটে গুছিয়ে রাখে ✅
- মেমোরি লেআউট ব্যবহার অনুসারে বদলায় → এস্কেপ অ্যানালাইসিসের সিদ্ধান্ত অনুসারে 📦🧳
- গারবেজ কালেক্টর শুধু হিপের মেমোরি পরিষ্কার করে, স্ট্যাক নয় 🧹

---

### প্রশ্ন: স্ট্রাক্ট কি একটি ডেটাটাইপ?

**উত্তর:** হ্যাঁ, ১০০% — Go-তে স্ট্রাক্ট হলো ব্যবহারকারীর তৈরি একটি ডেটাটাইপ। এটা এমন একটা "ব্লুপ্রিন্ট" যেটা দিয়ে তুমি নিজের মতো করে ডেটা অবজেক্ট বানাতে পারো। 💡

**কিভাবে:**

-[] Go তে `int`, `string`, `bool` ইত্যাদির মতো প্রিমিটিভ ডেটা টাইপ থাকে।
-[] তুমি `struct` ব্যবহার করে নিজের কাস্টম টাইপ তৈরি করতে পারো, যাতে একাধিক ফিল্ড একসাথে থাকে।

যেমন:

```go
type User struct {
	Name string
	Age  int
}
```

এখন User নিজেই একটা ডেটাটাইপ এর মতো কাজ করবে, আর তুমি এর ইনস্ট্যান্স তৈরি করে কাজ করতে পারো ঠিক `int` বা `string` এর মতো:

```go
var u User
u.Name = "Ruhin"
u.Age = 21
```

এটা এমন যেন তুমি নিজের মতো একটা লেগো ব্রিক তৈরি করছো, আর যত খুশি কপি বানাতে পারো। 🧱✨

> তোমার Go প্রোগ্রাম এখন স্ট্রাকচার্ড! 😎 পরের বার ডেটা মডেল করলে নিজের টাইপ তৈরি করো আর মেমোরি সেগমেন্ট বুঝে কাজ করো!

[**Author:** @ifrunruhin12, @nazma98
**Date:** 2025-05-01 - 2025-05-17
**Category:** interview-qa/class-wise
]
