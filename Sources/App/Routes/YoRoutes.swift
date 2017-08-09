import Vapor

final class YoRoutes: RouteCollection {
    func build(_ builder: RouteBuilder) throws {
        try builder.resource("yos", YoController.self)
    }
}


// MARK: EmptyInitializable
extension YoRoutes: EmptyInitializable {}
