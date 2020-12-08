// See https://forums.swift.org/t/add-groupby-method-to-sequence/37680

struct Group<Key, Element> {
    let key: Key
    var elements: [Element]
    init(_ key: Key) {
        self.key = key
        self.elements = []
    }
    
    mutating func append(_ newElement: Element) {
        self.elements.append(newElement)
    }
}

//implement Collection on Group by using the internal Array

extension Sequence {
    func groupBy<T: Hashable>(_ transform: (Self.Element) -> T) -> [Group<T, Self.Element>] {
        var groups: [T: Group<T, Self.Element>] = [:]
        for element in self {
            let key = transform(element)
            if groups[key] == nil {
                groups[key] = Group(key)
            }
            
            groups[key]?.append(element)
        }
        
        return Array(groups.values)
    }
}
