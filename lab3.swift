class Post_prototype {
    var content: String
    var likes: Int
    var comments: Int
    var shares: Int
    
    init(_ content: String,_ likes: Int,_ comments: Int,_ shares: Int){
        self.content = content
        self.likes = likes
        self.comments = comments
        self.shares = shares
    }
    
    func displayDetails(){
        preconditionFailure("This method must be overriden")
    }
}

func formatParameters(_ parameter: Int) -> String{
    if(parameter < 1000){
        return "\(parameter)"
    }
    else if(parameter < 1000000){
        return "\(parameter/1000)k"
    }
    else{
        return "\(parameter/1000000)m"
    }
}

class TextPost: Post_prototype{
    override func displayDetails(){
        print("Text content: \(content); Likes: \(formatParameters(likes)); Comments: \(formatParameters(comments)); Shares: \(formatParameters(shares))")
    }
}

class PhotoPost: Post_prototype{
    var URL: String
    
    init(_ content: String,_ likes: Int,_ comments: Int,_ shares: Int,_ URL: String){
        self.URL = URL
        super.init(content, likes, comments, shares)
    }
    
    override func displayDetails(){
        print("Text content: \(content); Photo URL: \(URL); Likes: \(formatParameters(likes)); Comments: \(formatParameters(comments)); Shares: \(formatParameters(shares)) ")
    }
}

class VideoPost: Post_prototype{
    var URL: String
    var seconds_length: Int
    
    init(_ content: String,_ likes: Int,_ comments: Int,_ shares: Int,_ URL: String,_ len: Int){
        self.URL = URL
        self.seconds_length = len
        super.init(content, likes, comments, shares)
    }
    
        override func displayDetails(){
        print("Text content: \(content); Video URL: \(URL); Length: \(seconds_length)s; Likes: \(formatParameters(likes)); Comments: \(formatParameters(comments)); Shares: \(formatParameters(shares))")
    }
}

struct User{
    var username: String
    var handle: String
}

class wholePost{
    var user: User
    var post: Post_prototype
    
    init(user:User, post:Post_prototype){
        self.user = user
        self.post = post
    }
    
    func display(){
        print("User: \(user.username)")
        print("Handle: \(user.handle)")
        post.displayDetails()
        print()
    }
}

let textPostPrototype = TextPost("Text post content", 1500, 300, 50)
let photoPostPrototype = PhotoPost("Photo post content", 2000, 400, 70, "Photo_URL")
let videoPostPrototype = VideoPost("Video post content", 250000000, 500, 80, "Video_URL", 120)

let user = User(username: "Adam Białek", handle: "@adamb")

let TextPost_example = wholePost(user: user, post: textPostPrototype)
let PhotoPost_example = wholePost(user: user, post: photoPostPrototype)
let VideoPost_example = wholePost(user: user, post: videoPostPrototype)

TextPost_example.display()
PhotoPost_example.display()
VideoPost_example.display()




