require 'rails_helper'

describe RecordLoader do
  it 'loads' do
    event = create(:event)
    result = GraphQL::Batch.batch do
      RecordLoader.for(Event).load(event.id)
    end
    expect(result).to eq(event)
  end
end