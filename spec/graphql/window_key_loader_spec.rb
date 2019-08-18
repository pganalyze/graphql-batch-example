require 'rails_helper'

describe WindowKeyLoader do
  it 'loads' do
    category = create(:category)
    events = (1..3).to_a.map do |n|
      create(:event, name: "Event #{n}", category: category)
    end

    result = GraphQL::Batch.batch do
      WindowKeyLoader.for(
        Event,
        :category_id,
        limit: 2, order_col: :id, order_dir: :asc
      ).load(category.id)
    end

    expect(result).to eq(events.first(2))
  end
end
