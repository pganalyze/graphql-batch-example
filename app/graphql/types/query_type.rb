module Types
  class QueryType < Types::BaseObject
    field :events, [Types::EventType], null: false, description: "All the events"

    def events
      Event.all
    end

    field :categories, [Types::CategoryType], null: false, description: "All the categories"

    def categories
      Category.all
    end
  end
end
