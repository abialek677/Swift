//                          Strings and text

var num1 = 5
var num2 = 10

print("\"\(num1) + \(num2) = \(num1 + num2)\"")

var str = "Gdansk University of Technology"
var str2 = ""

for character in str {
  if character == "n" {
    str2 += "⭐️"
  } else {
    str2 += "\(character)"
  }
}

print(str2)

let name = "Adam Bialek"
let nameReversed = name.reversed()

print(name + " -> " + nameReversed)

//                          Control flow

for _ in (1...11) {
  print("I will pass this course with best mark, because Swift is great!")
}

let n = 5

for i in (1...n) {
  print(i * i)
}

let n2 = 4

for _ in (1...n2) {
  for _ in (1...n2) {
    print("@", terminator: "")
  }
  print()
}

//                          Arrays

var numbers = [5, 10, 20, 15, 80, 13]

var max = numbers[0]

for i in (1...numbers.count - 1) {
  if numbers[i] > max {
    max = numbers[i]
  }
}

print(max)

for i in (0...numbers.count - 1).reversed() {
  print(String(numbers[i]) + " ", terminator: "")
}
print()

var allNumbers = [10, 20, 10, 11, 13, 20, 10, 30]
var unique: [Int] = []

for n in allNumbers {
  if !unique.contains(n) {
    unique.append(n)
  }
}

print("unique = \(unique)")

//                          Sets

var number = 10
var divisors: Set<Int> = []

for i in (1...number) {
  if number % i == 0 {
    divisors.insert(i)
  }
}

print(divisors.sorted())

//                          Dictionaries

var flights: [[String: String]] = [
  [
    "flightNumber": "AA8025",
    "destination": "Copenhagen",
  ],
  [
    "flightNumber": "BA1442",
    "destination": "New York",
  ],
  [
    "flightNumber": "BD6741",
    "destination": "Barcelona",
  ],
]

var flightNumbers: [String] = []

for dict in flights {
  for (keyword, value) in dict {
    if keyword == "flightNumber" {
      flightNumbers.append(value)
    }
  }
}

print("flightNumbers = \(flightNumbers)")

var names = ["Hommer", "Lisa", "Bart"]
let lastName = "Simpson"

var fullName: [[String: String]] = []

for fName in names {
  var dict: [String: String] = [:]
  dict["lastName"] = lastName
  dict["firstName"] = fName
  fullName.append(dict)
}

print(" ")
print("fullName = ")
for dict in fullName {
  print(dict)
}
