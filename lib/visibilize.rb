require "visibilize/version"
require "generator"

module Visibilize
  class Error < StandardError; end


  def visibilize(column, options={})

    column    = column              || :visible_id
    callback  = options[:callback]  || :before_create
    type      = options[:type]      || :integer
    unique    = options[:unique]    || true
    length    = options[:length]    || 8
    proc      = options[:proc]      || nil

    raise "Visibilize Error: Attribute #{column} not found in #{self.class} instance." unless self.has_attribute?(column)

    #Define a method to fill the column with appropiate value
    method_name="visibilize_#{column}"
    define_method(method_name) do

      #Values are generated by VisibilizeGenerator class
      value=proc ? proc : VisibilizeGenerator.get_value_for(type, column, length, unique)

      write_attribute(column, value)
    end

    #Create a callback to execute method
    callback=callback.to_s.split("_")
    set_callback callback[1].to_sym, callback[0].to_sym, method_name.to_sym

  end
  #end visibilize



end
