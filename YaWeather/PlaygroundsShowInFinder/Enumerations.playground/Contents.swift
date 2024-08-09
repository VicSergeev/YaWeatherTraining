import UIKit

// Enum - Group of related values

enum SocialPlatform {
    case twitter
    case insta
    case facebook
}

// basic usage is switch statement
func shareData(on platform: SocialPlatform) {
    switch platform {
    
    case .twitter:
        print("this is where the code would go to share some data on twitter")
    case .insta:
        print("this is where the code would go to share some data on instagram")
    case .facebook:
        print("this is where the code would go to share some data on facebook")
    }
}

// choose specific case
shareData(on: .facebook)

// MARK: - creating enum for using system images
enum SystemSymbols {
    static let sun      = UIImage(systemName: "sun")
    static let cloud    = UIImage(systemName: "cloud")
    static let cloudSun = UIImage(systemName: "cloud.sun")
}
// now we can access symbols that we are going to use in progect simple
// example of using - case .someIconOnUI:
//                         someImageToBeSet.image = SystemSymbols.cloudSun
// instead of typing someImageToBeSet = UIImage(systemName: "cloud.sun")
// also, below can be added additional properties like titleIcon.text = "Some text for icon"

// MARK: - enum in one row
enum Planet {
    case Earth, Mars, Jupiter
}

// MARK: - enums with raw values
enum WithRawValue: String {
    case valueOne   = "This is value one"
    case valueTwo   = "This is value two"
    case thirdValue = "This is value three"
}

func getValue(from enumeration: WithRawValue) {
    print(enumeration.rawValue)
}

getValue(from: .thirdValue)

enum WithIntAsRawValue: Int {
    case one = 1
    case two = 2
}

// MARK: - CaseIterable allow us to iterate through te cases of enum
// first of all your enum must to conform to this protocol
// CaseIterable make a collection from specific enumeration

enum GamingPlatform: String, CaseIterable {
    case Steam = "Your cat"
    case Arc = "The only way to get proper launcher for Star Trek Online"
}

func getData(from platform: GamingPlatform) {
    print(platform.rawValue)
}

getData(from: .Arc)
print(GamingPlatform.allCases.count) // how many cases

// loop thru collection from enum
for platform in GamingPlatform.allCases {
    print(platform.rawValue)
}

// MARK: - Associated values
enum OperatingSystem {
    case macOS(ver: Int) // (vesrion: Int) - Associated values
    case Windows(number: Int)
    case Linux // not every case must have an Associated value
}

func checkVersion(for platform: OperatingSystem) {
    switch platform {
        
    case .macOS(ver: let ver):
        if ver <= 10 {
            print("unable to use Xcode 15")
        }
    case .Windows(number: let number):
        if number >= 11 {
            print("wow, you finally have a corner radius in there, nice")
        }
    case .Linux:
        print("must...write...drivers...for everything")
    }
}

checkVersion(for: .Windows(number: 12))
