import Vapor
import HTTP

final class YoController: ResourceRepresentable {
    
    func index(req: Request) throws -> ResponseRepresentable {
        return try Yo.all().makeJSON()
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        
        guard let name = request.data["name"]?.string else {
            throw Abort.init(.preconditionFailed, metadata: ["message": "Missing name"])
        }
        
        let yo = Yo(name: name, length: "100")
        try yo.save()
        return yo
        
    }
    
    func makeResource() -> Resource<Yo> {
        return Resource(
            index: index,
            store: create
        )
    }
}

extension YoController: EmptyInitializable { }
