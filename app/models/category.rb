class Category < ActiveRecord::Base
  belongs_to :topic, touch: true, inverse_of: :categories
  has_many :values, -> { order 'values.name' }, inverse_of: :category, dependent: :destroy
  has_many :facts, as: :context

end
