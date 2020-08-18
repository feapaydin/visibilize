class Keyboard < ActiveRecord::Base

  visibilize  column: :serial_number, 
              type:   :uuid
  
end