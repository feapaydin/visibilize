# frozen_string_literal: true

class Car < ActiveRecord::Base
  visibilize column: :serial_number
end
