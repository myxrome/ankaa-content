class TopicGroup < ActiveRecord::Base
  include Order

  scope :neighbors, -> (topic_group) { all }
  def neighbors
    TopicGroup.neighbors(self)
  end

  has_many :topics, -> { order(:order) }, inverse_of: :topic_group, dependent: :destroy

  after_initialize :init_key

  def init_key
    self.key ||= SecureRandom.hex
  end

end
