# frozen_string_literal: true

class Furniture < ActiveRecord::Base
  visibilize callback: :before_update
end
