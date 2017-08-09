import Vapor
import HTTP

final class YoController: ResourceRepresentable {
    
    func index(req: Request) throws -> ResponseRepresentable {
        return try Yo.all().makeJSON()
    }
    
    func makeResource() -> Resource<Yo> {
        return Resource(
            index: index
        )
    }
}

extension YoController: EmptyInitializable { }
