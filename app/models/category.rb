class Category < ActiveRecord::Base
  include Order

  scope :neighbors, -> (category) { where(topic_id: category.topic_id) }
  def neighbors
    Category.neighbors(self)
  end

  belongs_to :topic, inverse_of: :categories
  has_many :values, -> { order(:name) }, inverse_of: :category, dependent: :destroy
  has_many :facts, as: :context

end
