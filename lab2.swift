//Functions

func minValue(_ num1: Int, _ num2: Int) -> Int{
  if(num1<num2){
    return num1
  }
  return num2
}

func lastDigit(_ num:Int) -> Int{
  return (num % 10)
}

func divides(_ num:Int, _ divisor:Int) -> Bool{
  return(num % divisor == 0)
}

func countDivisors (_ n:Int) -> Int{
  var counter = 0
  for i in 1...n{
    if(divides(n,i)){
      counter += 1
    }
  }
  return counter
}

func isPrime (_ n:Int) -> Bool{
  return(countDivisors(n) == 2)
}


print(minValue(3,5))
print(minValue(5,3))
print(minValue(10,11))
print(minValue(125,6))
print(" ")
print(lastDigit(1234))
print(lastDigit(7575759))
print(lastDigit(232))
print(" ")
print(divides(7,3))
print(divides(8,4))
print(" ")
print(countDivisors(1))
print(countDivisors(10))
print(countDivisors(12))
print(" ")
print(isPrime(3))
print(isPrime(8))
print(isPrime(1))

//Closures

let bartPrint: () -> Void = {
  print("I will pass this course with best mark, because Swift is great!")
}

func smartBart(_ n:Int, _ clos: () -> Void) -> Void{
  for _ in 1...n{
    clos()
  }
}
print(" ")
smartBart(11,bartPrint)

let numbers = [10, 16, 18, 30, 38, 40, 44, 50]
print(" ")
print(numbers.filter{$0 % 4 == 0})

func larger(_ n1:Int, _ n2:Int) -> Int{
  if(n1 > n2){
    return n1
  }
  return n2
}
print(" ")
print(numbers.reduce(numbers[0]){larger($0, $1)})
print(" ")
var strings = ["Gdansk", "University", "of", "Technology"]
print(strings.reduce(""){$0 + " " + $1})
print(" ")

let nums = [1, 2 ,3 ,4, 5, 6]

var filtered = nums.map{$0 * $0}.filter{$0 % 2 != 0}

for num in filtered{
  print(num, terminator: "")
  if(num != filtered[filtered.count - 1]){
    print(" + ", terminator: "")
  }
  else{
    print(" -> ", terminator: "")
  }
}

print(filtered.reduce(0){$0+$1})

//Tuples

func minmax( _ n1:Int, _ n2:Int) -> (Int,Int){
  if(n1 < n2){
    return (n1,n2)
  }
  return (n2,n1)
}

print(" ")
print(minmax(10,11))
print(minmax(11,10))
print(" ")


var strings2 = ["gdansk", "university", "gdansk", "university", "university",
"of", "technology", "technology", "gdansk", "gdansk"]

var wordCount: [(String,Int)] = []

var countDict: [String: Int] = [:]

for s in strings2 {
    countDict[s, default: 0] += 1
}

for (s,val) in countDict{
  wordCount.append((s,val))
}

print(wordCount)

print(" ")


enum Day: Int {
    case Monday = 1
    case Tuesday = 2
    case Wednesday = 3
    case Thursday = 4
    case Friday = 5
    case Saturday = 6
    case Sunday = 7
    
    func dayDescription() -> String {
        switch self {
        case .Monday:
            return "🐒"
        case .Tuesday:
            return "🐷"
        case .Wednesday:
            return "🐫"
        case .Thursday:
            return "🍔"
        case .Friday:
            return "🦍"
        case .Saturday:
            return "😂"
        case .Sunday:
            return "💀"
        }
    }
}


let someday = Day.Friday
print(someday.dayDescription(), " is ", someday.rawValue, "th day of the week")
let someday2 = Day.Sunday
print(someday2.dayDescription(), " is ", someday2.rawValue, "th day of the week")