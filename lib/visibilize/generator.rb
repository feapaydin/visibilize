require 'securerandom'

# VisibilizeGenerator
# Handles value generation for Visibilize w.r.t. provided type argument
#
module VisibilizeGenerator
  class << self
    def get_value_for(type, klass, column, length, unique)
      method = "generate_#{type}"

      if respond_to?(method)
        from = :generators
      elsif SecureRandom.respond_to?(type)
        from = :securerandom
      else
        raise "Visibilize Error: No generator defined for type #{type}. (Asked for column #{column} of #{klass.name})"
      end

      loop do
        if from == :generators
          generated = public_send(method, length)
        elsif from == :securerandom
          generated = generate_from_securerandom(type, length)
        end

        return generated if !unique || klass.where("#{column}='#{generated}'").empty?
      end
    end
    # end get_value_for

    #
    # Generators
    #

    def generate_integer(length)
      return rand(1...10) if length == 1

      min = 10**(length - 1)      # 1000
      max = 9 * min + (min - 1)   # 9999
      rand(min...(max + 1))
    end

    def generate_string(length)
      available_chars = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a

      str = ''
      length.times do
        str += available_chars[rand(available_chars.size)].to_s 
      end

      str
    end

    def generate_from_securerandom(type, length)
      if SecureRandom.respond_to?(type)
        begin
          return SecureRandom.public_send(type, length)
        rescue ArgumentError
          return SecureRandom.public_send(type)
        end
      end

      nil
    end
  end
  # end static
end
