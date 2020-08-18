class Furniture < ActiveRecord::Base

  visibilize callback: :before_update

end