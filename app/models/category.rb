class Category < ActiveRecord::Base
  belongs_to :topic, touch: true, inverse_of: :categories
  has_many :values, -> { order 'values.end_date' }, inverse_of: :category, dependent: :destroy

end
