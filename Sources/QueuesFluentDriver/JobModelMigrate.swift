import Foundation
import Fluent

public struct JobModelMigrate: Migration {
    public init() {}
    
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        let model = FluentQueue.model
        return database.schema(JobModel.schema)
            .field(model.$id.key,                .uuid,     .identifier(auto: false))
            .field(model.$key.key,               .string,   .required)
            .field(model.$data.key,              .data,     .required)
            .field(model.$state.key,             .string,   .required)
            .field(model.$createdAt.path.first!, .datetime)
            .field(model.$updatedAt.path.first!, .datetime)
            .field(model.$deletedAt.path.first!, .datetime)
            .create()
    }
    
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(JobModel.schema).delete()
    }
}
