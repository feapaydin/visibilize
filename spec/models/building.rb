# frozen_string_literal: true

class Building < ActiveRecord::Base
  # Please note that visibilize cannot provide uniqueness when using lambdas.
  # More Info: http://github.com/feapaydin/visibilize
  visibilize lambda: -> { return 3 + 9 }
end
