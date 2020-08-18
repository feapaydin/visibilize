class Book < ActiveRecord::Base

  # unique: true by default
  visibilize  column: :page_number,
              type:   :integer,
              length: 1  
end