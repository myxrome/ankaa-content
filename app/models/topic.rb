class Topic < ActiveRecord::Base
  include Orderable

  scope :neighbors, -> (topic) { where(topic_group_id: topic.topic_group_id) }
  def neighbors
    Topic.neighbors(self)
  end

  belongs_to :topic_group, inverse_of: :topics
  has_many :categories, -> { where(active: true).order(:order) }, inverse_of: :topic, dependent: :destroy
  has_many :facts, as: :context

end
