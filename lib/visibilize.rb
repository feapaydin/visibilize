# frozen_string_literal: true

require 'visibilize/version'
require 'visibilize/generator'

# Raised when the column is not found in the model
class AttributeNotFoundError < StandardError
  def initialize(column, klass)
    super("Visibilize Error: Attribute #{column} not found in #{klass.name} instance.")
  end
end

# Visibilize
#
# @param [Hash] options
# @option options [Symbol] :column The column to be generated
# @option options [Symbol] :callback The callback to be used (before_create, before_save, etc.)
# @option options [Symbol] :type The type of value to be generated (integer, string, uuid, etc.)
# @option options [Boolean] :unique Whether the value should be unique
# @option options [Integer] :length The length of the value to be generated
# @option options [Proc] :lambda A lambda to be used to generate the value
def visibilize(options = {})
  options.reverse_merge!(column: :visible_id, callback: :before_create, type: :integer, unique: true, length: 8)

  # Define a method to fill the column with an appropiate value
  define_visibilize_method(**options.slice(:column, :type, :unique, :length, :lambda))

  # Create a callback to execute method
  callback_type, _, callback_timing = options[:callback].to_s.partition('_')
  set_callback callback_timing.to_sym, callback_type.to_sym, method_name(options[:column])
end

def define_visibilize_method(column: :visible_id, type: :integer, unique: true, length: 8, lambda: nil)
  define_method(method_name(column)) do
    raise AttributeNotFoundError.new(column, self.class) unless has_attribute?(column)

    value = lambda&.call || VisibilizeGenerator.value(type, self.class, column, length, unique)
    write_attribute(column, value)
  end
end

def method_name(column)
  "visibilize_#{column}".to_sym
end
