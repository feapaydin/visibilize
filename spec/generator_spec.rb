# frozen_string_literal: true

RSpec.describe VisibilizeGenerator do # rubocop:disable Metrics/BlockLength
  it 'can create integers with custom length' do
    value = VisibilizeGenerator.value(:integer, nil, :visible_id, 5, false)
    expect(value.class).to be Integer
    expect(value.to_s.length).to be 5
  end

  it 'can create strings with custom length' do
    value = VisibilizeGenerator.value(:string, nil, :visible_id, 5, false)
    expect(value.class).to be String
    expect(value.length).to be 5
  end

  it 'can create SecureRandom values' do
    value = VisibilizeGenerator.value(:uuid, nil, :visible_id, 5, false)
    expect(value.class).to be String
    expect(value).to match UUID_REGEX
  end

  describe 'error handling' do
    it 'raises NoVisibilizeGeneratorError for unsupported type' do
      expect { VisibilizeGenerator.value(:unsupported_type, User, :visible_id, 5, false) }
        .to raise_error(VisibilizeGenerator::InvalidGeneratorError)
    end

    it 'raises VisibilizeAttemptsExceededError when unique value cannot be generated' do
      allow(User).to receive(:exists?).and_return(true)
      expect { VisibilizeGenerator.value(:integer, User, :visible_id, 5, true) }
        .to raise_error(VisibilizeGenerator::AttemptsExceededError)
    end
  end
end
