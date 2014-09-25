class Category < ActiveRecord::Base
  require 'concerns/orderable'
  include Orderable

  scope :neighbors, -> (category) { where(topic_id: category.topic_id) }

  def neighbors
    Category.neighbors(self)
  end

  belongs_to :topic, touch: true, inverse_of: :categories
  has_many :values, -> { where(active: true).order(:name) }, inverse_of: :category, dependent: :destroy
  has_many :facts, as: :context

end
