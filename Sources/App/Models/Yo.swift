import Vapor
import FluentProvider
import HTTP

final class Yo: Model {

    let storage = Storage()
    
    //Properties
    var name: String
    var length: String
    
    /// Database fields
    static let idKey = "id"
    static let nameKey = "name"
    static let lengthKey = "length"
    
    /// Creates a new Yo
    init(name: String, length: String) {
        self.name = name
        self.length = length
    }
    
    /// Initializes the Yo from the DB
    init(row: Row) throws {
        name = try row.get(Yo.nameKey)
        length = try row.get(Yo.lengthKey)
    }
    
    // Serializes the Yo to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Yo.nameKey, name)
        try row.set(Yo.lengthKey, length)
        return row
    }
    
}

// MARK: Fluent Preparation

extension Yo: Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(Yo.nameKey)
            builder.string(Yo.lengthKey)
        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Yo: JSONConvertible {
    convenience init(json: JSON) throws {
        try self.init(
            name: json.get(Yo.nameKey),
            length: json.get(Yo.lengthKey)
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Yo.idKey, id)
        try json.set(Yo.nameKey, name)
        try json.set(Yo.lengthKey, length)
        return json
    }
}

extension Yo: ResponseRepresentable { }
