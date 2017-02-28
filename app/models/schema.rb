UserType = GraphQL::ObjectType.define do
  name 'User'
  description '...'

  field :id, !types.String
  field :email, !types.String
end

PostType = GraphQL::ObjectType.define do
  name 'Post'
  description '...'

  field :id, !types.String
  field :title, !types.String
  field :content, !types.String
  field :user do
   type UserType
   resolve -> (obj, args, ctx) {
     obj.user
   }
 end
end

QueryRoot = GraphQL::ObjectType.define do
  name 'Query'
  description '...'

  field :user do
    type UserType
    argument :id, !types.String
    resolve -> (root, args, ctx) {
      User.find(args[:id])
    }
  end

  field :post do
    type PostType
    argument :id, !types.String
    resolve -> (root, args, ctx) {
      Post.find(args[:id])
    }
  end
end

Schema = GraphQL::Schema.new(
  query: QueryRoot
)
