# frozen_string_literal: true

RSpec.describe VisibilizeGenerator do
  it 'can create integers with custom length' do
    value = VisibilizeGenerator.get_value_for(:integer, nil, :visible_id, 5, false)
    expect(value.class).to be Integer
    expect(value.to_s.length).to be 5
  end

  it 'can create strings with custom length' do
    value = VisibilizeGenerator.get_value_for(:string, nil, :visible_id, 5, false)
    expect(value.class).to be String
    expect(value.length).to be 5
  end

  it 'can create SecureRandom values' do
    value = VisibilizeGenerator.get_value_for(:uuid, nil, :visible_id, 5, false)
    expect(value.class).to be String
    expect(value).to match UUID_REGEX
  end
end
