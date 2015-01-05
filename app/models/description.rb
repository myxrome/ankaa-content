class Description < ActiveRecord::Base
  belongs_to :value, inverse_of: :descriptions

end
