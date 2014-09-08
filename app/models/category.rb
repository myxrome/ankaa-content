class Category < ActiveRecord::Base
  require 'concerns/active_model'
  include ActiveModel

  belongs_to :topic, touch: true, inverse_of: :categories
  has_many :values, -> { where active: true }, inverse_of: :category, dependent: :destroy
  has_many :facts, as: :context

end
