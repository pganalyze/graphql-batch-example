Rails.application.routes.default_url_options[:host] = "localhost:3000"
Rails.application.routes.default_url_options[:protocol] = "http"

class Types::EventType < Types::BaseObject
  include Rails.application.routes.url_helpers
  graphql_name "Event"

  field :id, ID, null: false
  field :name, String, null: false

  field :category, Types::CategoryType, null: false

  def category
    RecordLoader.for(Category).load(object.category_id)
  end

  field :image, String, null: true

  def image
    # produces 2N + 1 queries... yikes!
    return url_for(object.image.variant({ quality: 75 }))

    # AttachmentLoader.for(:Event, :image).load(object.id).then do |image|
    #   url_for(image.variant({ quality: 75 }))
    # end
  end
end