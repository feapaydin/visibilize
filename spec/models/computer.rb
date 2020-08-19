# frozen_string_literal: true

class Computer < ActiveRecord::Base
  visibilize  column: :serial_number,
              length: 50,
              type: :string
end
