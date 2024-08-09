import UIKit

func determineHigherValue<T: Comparable>(valueOne: T, valueTwo: T) { // comparing two same types, not different types
    let higherValue = valueOne > valueTwo ? valueOne : valueTwo
    print("\(higherValue) is the higher value")
}

determineHigherValue(valueOne: 4, valueTwo: 9)
// alphabetic order
determineHigherValue(valueOne: "Swift", valueTwo: "Java")
// u can compare any types that conform to Comparable
determineHigherValue(valueOne: Date.distantFuture, valueTwo: Date.distantPast)

// array is generic type of <Element>
// not to make overcomplicated things don't use generics if u need only couple of repetative things, but if there are many almost the same tasks, or u have to repeat code more that couple of times - use generics
