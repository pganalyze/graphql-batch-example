class WindowKeyLoader < GraphQL::Batch::Loader
  attr_reader :model, :foreign_key, :limit, :order_col, :order_dir

  def initialize(model, foreign_key, limit:, order_col: :id, order_dir: :asc)
    @model = model
    @foreign_key = foreign_key
    @limit = limit
    @order_col = order_col
    @order_dir = order_dir
  end

  def perform(foreign_ids)
    # build the sub-query, limiting results by foreign key at this point
    # we don't want to execute this query but get its SQL to be used later
    ranked_from = model.
      select("*,
        row_number() OVER (
          PARTITION BY #{foreign_key} ORDER BY #{order_col} #{order_dir}
        ) as rank").
      where(foreign_key => foreign_ids).
      to_sql

    # use the sub-query from above to query records which have a rank
    # value less than or equal to our limit
    records = model.
      from("(#{ranked_from}) as #{model.table_name}").
      where("rank <= #{limit}").
      to_a

    # match records and fulfill promises
    foreign_ids.each do |foreign_id|
      matching_records = records.select do |r|
        foreign_id == r.send(foreign_key)
      end
      fulfill(foreign_id, matching_records)
    end
  end
end