# frozen_string_literal: true

class Keyboard < ActiveRecord::Base
  visibilize  column: :serial_number,
              type: :uuid
end
