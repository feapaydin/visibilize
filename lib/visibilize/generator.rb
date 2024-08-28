# frozen_string_literal: true

require 'securerandom'

# Handles value generation for Visibilize w.r.t. provided type argument
module VisibilizeGenerator
  # Raised when the generator is not found for the given type
  class InvalidGeneratorError < StandardError
    def initialize(type, klass, column)
      super("Visibilize Error: No generator defined for type #{type}. (Asked for column #{column} of #{klass.name})")
    end
  end

  # Raised when the maximum number of attempts to generate a unique value is exceeded
  class AttemptsExceededError < StandardError
    def initialize(attempts)
      super("Visibilize Error: Failed to generate a unique value after #{attempts} attempts")
    end
  end

  class << self
    # We're limiting the number of attempts to generate a unique value to 10
    # This is to prevent infinite loops in case of collisions
    MAX_UNIQUE_ATTEMPTS = 10

    def value(type, klass, column, length, unique)
      return generate_value(type, klass, column, length) unless unique

      MAX_UNIQUE_ATTEMPTS.times do
        generated = generate_value(type, klass, column, length)
        return generated unless klass.exists?(column => generated)
      end
      raise AttemptsExceededError, MAX_UNIQUE_ATTEMPTS
    end

    def generate_value(type, klass, column, length)
      case type
      when :integer then generate_integer(length)
      when :string then generate_string(length)
      else
        raise InvalidGeneratorError.new(type, klass, column) unless SecureRandom.respond_to?(type)

        generate_from_securerandom(type, length)
      end
    end

    private

    def generate_integer(length)
      return rand(1...10) if length == 1

      min = 10**(length - 1)
      max = (10**length) - 1
      rand(min..max)
    end

    def generate_string(length)
      available_chars = [*'a'..'z', *'A'..'Z', *'0'..'9']
      Array.new(length) { available_chars.sample }.join
    end

    def generate_from_securerandom(type, length)
      SecureRandom.public_send(type, length)
    rescue ArgumentError
      SecureRandom.public_send(type)
    end
  end
end
