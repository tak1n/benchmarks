require "graphql"
require "hanami/api"
require "hanami/middleware/body_parser"

class QueryType < GraphQL::Schema::Object
  field :hello, String, null: false

  def hello
    "world"
  end
end


class Schema < GraphQL::Schema
  query QueryType
end

class App < Hanami::API
  post "/graphql" do
    result = Schema.execute(params[:query], variables: params[:variables])

    json(result)
  end

  get "/" do
    "Hello, world"
  end
end

use Hanami::Middleware::BodyParser, :json
run App.new
