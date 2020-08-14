RSpec.describe VisibilizeGenerator do

  it "can create integers with custom length" do
    value=VisibilizeGenerator.get_value_for(:integer, :visible_id, 5, false)
    expect(value.class).to be Integer
    expect(value.to_s.length).to be 5
  end

  it "can create strings with custom length" do
    value=VisibilizeGenerator.get_value_for(:string, :visible_id, 5, false)
    expect(value.class).to be String
    expect(value.length).to be 5
  end

  it "can create SecureRandom values" do
    value=VisibilizeGenerator.get_value_for(:uuid, :visible_id, 5, false)
    expect(value.class).to be String
    expect(value).to match /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
  end


end
