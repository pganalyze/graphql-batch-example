class Types::CategoryType < Types::BaseObject
  graphql_name "Category"

  field :id, ID, null: false
  field :name, String, null: false
  field :slug, String, null: false

  field :events, [Types::EventType], null: false do
    argument :first, Int, required: false, default_value: 5
  end

  def events(first:)
    # ForeignKeyLoader.for(Event, :category_id, merge: -> { order(id: :asc) }).
    #   load(object.id).then do |records|
    #     records.first(first)
    #   end
    WindowKeyLoader.for(Event, :category_id,
      limit: first,
      order_col: :start_time,
      order_dir: :desc
    ).load(object.id)
  end
end