# frozen_string_literal: true

require 'visibilize/version'
require 'visibilize/generator'

def visibilize(options={})
  column    = options[:column]    || :visible_id
  callback  = options[:callback]  || :before_create
  type      = options[:type]      || :integer
  unique    = options[:unique]    || true
  length    = options[:length]    || 8
  lamb      = options[:lambda]    || nil

  # Define a method to fill the column with appropiate value
  method_name = "visibilize_#{column}"
  define_method(method_name) do
    unless has_attribute?(column)
      raise "Visibilize Error: Attribute #{column} not found in #{self.class.name} instance."
    end

    # Values are generated by VisibilizeGenerator class
    value = lamb ? lamb.call : VisibilizeGenerator.get_value_for(type, self.class, column, length, unique)

    write_attribute(column, value)
  end

  # Create a callback to execute method
  callback = callback.to_s.split('_')
  set_callback callback[1].to_sym, callback[0].to_sym, method_name.to_sym
end
# end visibilize
