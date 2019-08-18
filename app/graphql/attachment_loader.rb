class AttachmentLoader < GraphQL::Batch::Loader
  attr_reader :record_type, :attachment_name

  def initialize(record_type, attachment_name)
    @record_type = record_type
    @attachment_name = attachment_name
  end

  def perform(record_ids)
    # find records and fulfill promises
    ActiveStorage::Attachment.
      includes(:blob).
      where(record_type: record_type, record_id: record_ids, name: attachment_name).
      each { |record| fulfill(record.record_id, record) }

    # fulfill unfound records
    record_ids.each { |id| fulfill(id, nil) unless fulfilled?(id) }
  end
end