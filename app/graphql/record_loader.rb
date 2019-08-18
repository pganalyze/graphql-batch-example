class RecordLoader < GraphQL::Batch::Loader
  def initialize(model)
    @model = model
  end

  def perform(ids)
    # Find all ids for this model and fulfill their promises
    @model.where(id: ids).each { |record| fulfill(record.id, record) }
    # Handle cases where a record was not found and fulfill the value as nil
    ids.each { |id| fulfill(id, nil) unless fulfilled?(id) }
  end
end