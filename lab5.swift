import Foundation

class wordGame{
    var word: String
    var guessesRemaining: Int
    var guessedLetters: [Character]

    var guessedWord: String{
        var guessedWord = ""
        for letter in word{
            if guessedLetters.contains(letter){
                guessedWord += String(letter)
            }
            else if(String(letter) == " "){
                guessedWord += " "
            }
            else{
                guessedWord += "_"
            }
        }
        return guessedWord
    }

    init(word: String, guessesRemaining: Int){
        self.word = word
        self.guessesRemaining = guessesRemaining
        self.guessedLetters = []
    }

    func playerGuessed(letter: Character) -> Int{
        if !guessedLetters.contains(letter){
            let lowercaseLetter = Character(letter.lowercased())
            let uppercaseLetter = Character(letter.uppercased())
            guessedLetters.append(lowercaseLetter)
            guessedLetters.append(uppercaseLetter)
        }
        else{
            print("You already guessed that letter!")
            return -1;
        }
        return 0;
    }
    func isGameOver() -> Bool {
        if guessesRemaining == 0 || guessedWord == word{
            return true
        }
        
        return false
    }
    
    func playGame() {
        while !isGameOver() {
            print("Guessed Word: \(guessedWord)")
            print("Guesses Remaining: \(guessesRemaining)")
            
            print("Enter a letter: ", terminator: "")
            let input = readLine()
            
            if let letter = input?.first {
                let val = playerGuessed(letter: letter)
                if val == -1{
                    continue
                }
                if !word.contains(letter) {
                    guessesRemaining -= 1
                }
            }
        }
        
        if guessedWord == word {
            print("You won")
        } else {
            print("Game Over! The word was: \(word)")
        }
    }
}
enum Category {
    case cities
    case movies
    case books
}

func selectCategory() -> Category {
    print("Select a category:")
    print("1. Cities")
    print("2. Movies")
    print("3. Books")
    while(true){
        let input = readLine()
            switch Int(input ?? "") {
            case 1:
                return .cities
            case 2:
                return .movies
            case 3:
                return .books
            default:
                print("Invalid choice. Please try again.")
        }
    }
    
    
   
}

func getRandomWord(category: Category) -> String {
    switch category {
    case .cities:
        let cities = ["New York", "Paris", "Tokyo", "London", "Rome"]
        return cities.randomElement() ?? ""
    case .movies:
        let movies = ["The Godfather", "Inception", "Pulp Fiction", "The Shawshank Redemption", "Fight Club"]
        return movies.randomElement() ?? ""
    case .books:
        let books = ["To Kill a Mockingbird", "The Great Gatsby", "The Catcher in the Rye", "Moby-Dick"]
        return books.randomElement() ?? ""
    }
}

func chooseDifficulty() -> Int{
    print("Choose difficulty")
    print("1. Easy")
    print("2. Medium")
    print("3. Hard")
    while(true){
        let input = readLine()
            switch Int(input ?? "") {
            case 1:
                return 15
            case 2:
                return 8
            case 3:
                return 3
            default:
                print("Invalid choice. Please try again.")
        }
    }
}




var cat = selectCategory()

var word = getRandomWord(category: cat)

let moves = chooseDifficulty()


var Game = wordGame(word: word, guessesRemaining: moves)
Game.playGame()
