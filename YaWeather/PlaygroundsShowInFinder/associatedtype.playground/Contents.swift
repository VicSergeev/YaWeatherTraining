import Foundation

protocol Appendable {
    associatedtype Item
    
    func append(_ item: Item)
}

class CustomArray: Appendable {
    
    typealias Item = String // associated type asked which type is it has to be
    // typealias creates a nickname for associated type
    
    func append(_ item: String) { // here is String cause we set it in typealias
        
    }
}

class CustomArrayOfInts: Appendable {
    func append(_ item: Int) { // and here is an Int cause typealias
        
    }
    
    typealias Item = Int
    
    
}
