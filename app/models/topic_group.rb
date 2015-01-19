class TopicGroup < ActiveRecord::Base
  has_many :topics, -> { order(:order) }, inverse_of: :topic_group, dependent: :destroy
  has_many :facts, as: :context

  after_initialize :init_key

  def init_key
    self.key ||= SecureRandom.hex
  end

  def destroy
    raise 'Cannot delete Topic Group with active Topics' unless topics.where(active: true).count == 0
    super
  end

end
