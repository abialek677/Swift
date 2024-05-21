import Foundation

enum Tags {
    case seaside
    case party
    case sport
    case music
    case nature
    case urban
    case culture
}

enum Types {
    case restaurant
    case pub
    case museum
    case monument
}

class Location{
    let id: Int
    let type: Types
    let name: String
    let rating: Int
    
    init(_ id: Int,_ type: Types,_ name: String,_ rating: Int) {
        self.id = id
        self.type = type
        self.name = name
        self.rating = rating
    }
    
    func display() {
        print("\tLocation ID: \(id)")
        print("\tType: \(type)")
        print("\tName: \(name)")
        print("\tRating: \(rating)")
    }
}

class City {
    var id: Int
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    var tags: [Tags]
    
    init(_ id: Int, _ name: String, _ description: String, _ latitude: Double, _ longitude: Double, _ tags: [Tags]) {
        self.id = id
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.tags = tags
    }
    
    func display() {
        print("City ID: \(id)")
        print("Name: \(name)")
        print("Description: \(description)")
        print("Latitude: \(latitude)")
        print("Longitude: \(longitude)")
        print("Tags: \(tags)")
    }
    
}


class CityExtended: City{
    var locations:[Location]
    
    init(_ id: Int,_ name: String,_ description: String,_ latitude: Double,_ longitude: Double,_ tags: [Tags],_ locations: [Location]) {
        self.locations = locations
        super.init(id, name, description, latitude, longitude, tags)
    }
    
    override func display() {
        super.display()
        
        print("Locations:")
        for location in locations {
            location.display()
            print(" ")
        }
    }
    
}


func searchName(_ name: String, _ cities: [City]) -> [City]{
    return cities.filter{$0.name == name}
}


func search5starRest(_ cities: [CityExtended]){
    let citiesTab = cities.filter{c in c.locations.contains{$0.rating == 5 && $0.type == .restaurant}}
    
    print("Cities with restaurants with 5* rating: ")
    for c in citiesTab{
        print(c.name)
    }
}

func locationsSort(_ city: CityExtended) -> [Location]{
    return city.locations.sorted{$0.rating > $1.rating}
}

func show5starCities(_ cities: [CityExtended]){
    for city in cities{
        print("City: \(city.name)")
        
        let filteredLocations = city.locations.filter{$0.rating == 5}
        
        print("Number of 5* locations: \(filteredLocations.count)")
        
        for loc in filteredLocations{
            loc.display()
        }
        print(" ")
    }
    
    
}


func searchTags(_ tag: Tags, _ cities: [City]) -> [City]{
    return cities.filter{$0.tags.contains{$0 == tag}}
}

func calc2cities(_ name1: String, _ name2: String, _ cities: [City]) -> Double{
    let city1 = searchName(name1, cities)[0]
    let city2 = searchName(name2, cities)[0]
    let radius = 6371.0
    
    let lon1 = city1.longitude * Double.pi / 180.0
    let lon2 = city2.longitude * Double.pi / 180.0
    let lat1 = city1.latitude * Double.pi / 180.0
    let lat2 = city2.latitude * Double.pi / 180.0
    
    let deltaLon = lon1 - lon2
    let deltaLat = lat1 - lat2
    
    let a = sin(deltaLat/2.0) * sin(deltaLat/2.0) + cos(lat1) * cos(lat2) * sin(deltaLon/2.0) * sin(deltaLon/2.0)
    
    let c = 2 * atan2(sqrt(a), sqrt(1-a))
    
    return radius*c
}

func calc2citiesLatLon(_ latitude: Double, _ longitude: Double, _ name: String, _ cities: [City]) -> Double{
    let city = searchName(name, cities)
    let radius = 6371.0
    
    let lon = city[0].longitude * Double.pi / 180.0
    let lat = city[0].latitude * Double.pi / 180.0
    
    let deltaLon = (lon - longitude)
    let deltaLat = (lat - latitude)
    
    let a = sin(deltaLat/2.0) * sin(deltaLat/2.0) + cos(lat) * cos(latitude) * sin(deltaLon/2.0) * sin(deltaLon/2.0)
    
    let c = 2 * atan2(sqrt(a), sqrt(1-a))
    return radius*c
}


func closestFurthestCity(_ latitude: Double, _ longitude: Double, _ cities: [City]){
    var minDist = Double.infinity
    var closestCity = cities[0]
    
    var maxDist = 0.0
    var furthestCity = cities[0]
    
    for city in cities {
        let dist = calc2citiesLatLon(latitude, longitude, city.name, cities)
        //print(city.name)
        //print("\(dist)")
        if dist < minDist{
            minDist = dist
            closestCity = city
        }
        
        if dist > maxDist{
            maxDist = dist
            furthestCity = city
        }
        
    }
    
    print("For coordinates:")
    print("Latitude = \(latitude)")
    print("Longitude = \(longitude)")
    print(" ")
    print("Furthest city: \(furthestCity.name)")
    print("Closest city: \(closestCity.name)")
}


func furthestCities(_ cities: [City]){

    var maxDist = 0.0
    var city1 = cities[0]
    var city2 = cities[0]
    for i in cities.indices{
        for j in i...(cities.count-1){
            let dist = calc2cities(cities[i].name, cities[j].name, cities)
            if dist > maxDist{
                maxDist = dist
                city1 = cities[i]
                city2 = cities[j]
            }
        }
    }
    
    print("Two furthest cities: ")
    print(city1.name)
    print(city2.name)
}



let Cities: [City] = [
    City(1, "Warszawa", "Stolica Polski", 52.2297, 21.0122, [.party, .culture]),
    City(2, "Kraków", "Miasto królewskie", 50.0647, 19.9450, [.culture, .nature]),
    City(3, "Łódź", "Miasto przemysłowe", 51.7592, 19.4551, [.urban, .culture]),
    City(4, "Wrocław", "Miasto nad Odrą", 51.1079, 17.0385, [.culture, .nature]),
    City(5, "Poznań", "Miasto historyczne", 52.4064, 16.9252, [.culture, .nature]),
    City(6, "Gdańsk", "Miasto portowe", 54.3520, 18.6466, [.seaside, .culture]),
    City(7, "Szczecin", "Miasto nad Odrą", 53.4289, 14.5530, [.seaside, .culture]),
    City(8, "Bydgoszcz", "Miasto nad Brdą", 53.1235, 18.0084, [.urban, .culture]),
    City(9, "Lublin", "Miasto akademickie", 51.2465, 22.5684, [.urban, .culture]),
    City(10, "Białystok", "Miasto na Podlasiu", 53.1325, 23.1688, [.culture, .nature]),
    City(11, "Katowice", "Stolica Górnego Śląska", 50.2649, 19.0238, [.urban, .culture]),
    City(12, "Gdynia", "Miasto portowe", 54.5189, 18.5305, [.seaside, .culture]),
    City(13, "Częstochowa", "Miasto pielgrzymkowe", 50.8110, 19.1200, [.culture, .nature]),
    City(14, "Radom", "Miasto nad rzeką Mleczną", 51.4025, 21.1561, [.urban, .culture]),
    City(15, "Sosnowiec", "Miasto przemysłowe", 50.2866, 19.1033, [.urban, .culture]),
    City(16, "Toruń", "Miasto Kopernika", 53.0138, 18.5984, [.culture, .nature]),
    City(17, "Kielce", "Miasto na Górnym Śląsku", 50.8661, 20.6286, [.urban, .culture]),
    City(18, "Rzeszów", "Stolica Podkarpacia", 50.0412, 21.9991, [.urban, .culture]),
    City(19, "Olsztyn", "Miasto na Mazurach", 53.7784, 20.4801, [.nature]),
    City(20, "Zielona Góra", "Miasto w województwie lubuskim", 51.9356, 15.5064, [.nature])
]

let citiesExtended: [CityExtended] = [
    CityExtended(1, "Warszawa", "Stolica Polski", 52.2297, 21.0122, [.party, .culture], [
        Location(1, .restaurant, "Restaurant A", 4),
        Location(2, .pub, "Pub B", 3)
    ]),
    CityExtended(2, "Kraków", "Miasto królewskie", 50.0647, 19.9450, [.culture, .nature], [
        Location(3, .museum, "Museum X", 5),
        Location(4, .monument, "Monument Y", 4)
    ]),
    CityExtended(3, "Łódź", "Miasto przemysłowe", 51.7592, 19.4551, [.urban, .culture], [
        Location(5, .restaurant, "Restaurant C", 3),
        Location(6, .museum, "Museum Z", 4)
    ]),
    CityExtended(4, "Wrocław", "Miasto nad Odrą", 51.1079, 17.0385, [.culture, .nature], [
        Location(7, .restaurant, "Restaurant D", 4),
        Location(8, .monument, "Monument W", 3)
    ]),
    CityExtended(5, "Poznań", "Miasto historyczne", 52.4064, 16.9252, [.culture, .nature], [
        Location(9, .pub, "Pub E", 4),
        Location(10, .museum, "Museum Y", 5)
    ]),
    CityExtended(6, "Gdańsk", "Miasto portowe", 54.3520, 18.6466, [.seaside, .culture], [
        Location(11, .restaurant, "Restaurant F", 4),
        Location(12, .pub, "Pub G", 3)
    ]),
    CityExtended(7, "Szczecin", "Miasto nad Odrą", 53.4289, 14.5530, [.seaside, .culture], [
        Location(13, .restaurant, "Restaurant H", 3),
        Location(14, .pub, "Pub I", 4)
    ]),
    CityExtended(8, "Bydgoszcz", "Miasto nad Brdą", 53.1235, 18.0084, [.urban, .culture], [
        Location(15, .museum, "Museum M", 4),
        Location(16, .monument, "Monument N", 3)
    ]),
    CityExtended(9, "Lublin", "Miasto akademickie", 51.2465, 22.5684, [.urban, .culture], [
        Location(17, .restaurant, "Restaurant J", 3),
        Location(18, .museum, "Museum O", 5)
    ]),
    CityExtended(10, "Białystok", "Miasto na Podlasiu", 53.1325, 23.1688, [.culture, .nature], [
        Location(19, .pub, "Pub K", 4),
        Location(20, .monument, "Monument P", 3)
    ]),
    CityExtended(11, "Katowice", "Stolica Górnego Śląska", 50.2649, 19.0238, [.urban, .culture], [
        Location(21, .restaurant, "Restaurant L", 4),
        Location(22, .pub, "Pub Q", 3)
    ]),
    CityExtended(12, "Gdynia", "Miasto portowe", 54.5189, 18.5305, [.seaside, .culture], [
        Location(23, .restaurant, "Restaurant R", 3),
        Location(24, .pub, "Pub S", 4)
    ]),
    CityExtended(13, "Częstochowa", "Miasto pielgrzymkowe", 50.8110, 19.1200, [.culture, .nature], [
        Location(25, .museum, "Museum T", 4),
        Location(26, .monument, "Monument U", 3)
    ]),
    CityExtended(14, "Radom", "Miasto nad rzeką Mleczną", 51.4025, 21.1561, [.urban, .culture], [
        Location(27, .restaurant, "Restaurant V", 5),
        Location(28, .pub, "Pub W", 3)
    ]),
    CityExtended(15, "Sosnowiec", "Miasto przemysłowe", 50.2866, 19.1033, [.urban, .culture], [
        Location(29, .restaurant, "Restaurant X", 3),
        Location(30, .pub, "Pub Y", 4)
    ]),
    CityExtended(16, "Toruń", "Miasto Kopernika", 53.0138, 18.5984, [.culture, .nature], [
        Location(31, .museum, "Museum Z", 5),
        Location(32, .monument, "Monument AA", 4)
    ]),
    CityExtended(17, "Kielce", "Miasto na Górnym Śląsku", 50.8661, 20.6286, [.urban, .culture], [
        Location(33, .restaurant, "Restaurant AB", 5),
        Location(34, .pub, "Pub AC", 3)
    ]),
    CityExtended(18, "Rzeszów", "Stolica Podkarpacia", 50.0412, 21.9991, [.urban, .culture], [
        Location(35, .museum, "Museum AD", 4),
        Location(36, .monument, "Monument AE", 3)
    ]),
    CityExtended(19, "Olsztyn", "Miasto na Mazurach", 53.7784, 20.4801, [.nature], [
        Location(37, .restaurant, "Restaurant AF", 3),
        Location(38, .pub, "Pub AG", 4)
    ]),
    CityExtended(20, "Zielona Góra", "Miasto w województwie lubuskim", 51.9356, 15.5064, [.nature], [
        Location(39, .museum, "Museum AH", 2),
        Location(40, .monument, "Monument AI", 3)
    ])
]


print("Searching Kielce")
print(" ")
let cityTab = searchName("Kielce", Cities)

for c in cityTab{
    c.display()
}

print(" ")
print(" ")
print(" ")
print("Searching tag .seaside")
print(" ")
let cityTab2 = searchTags( .seaside, Cities)

for c in cityTab2{
    c.display()
}
print(" ")
print(" ")
print(" ")
print("Calculate dist between 2 cities")
print(" ")
let dist = calc2cities("Warszawa", "Kraków", Cities)
print("\(dist)km")
print(" ")
print(" ")
print(" ")
print("Show closest and furthest city to set coords")
print(" ")
closestFurthestCity(10.0, 15.0, Cities)
print(" ")
print(" ")
print(" ")
print("Show two furthest cities from each other")
print(" ")
furthestCities(Cities)
print(" ")
print(" ")
print(" ")
search5starRest(citiesExtended)
print(" ")
print(" ")
print(" ")
print("Showing sorted locations in descending order for city \(citiesExtended[0].name)")
let sortedLocations = locationsSort(citiesExtended[0])

for locat in sortedLocations{
  locat.display()
}
print(" ")
print(" ")
print(" ")
print("Showing amount of 5* locations each city has")
print(" ")
show5starCities(citiesExtended)

