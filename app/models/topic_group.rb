class TopicGroup < ActiveRecord::Base
  has_many :topics, -> { order(:order) }, inverse_of: :topic_group, dependent: :destroy
  has_many :facts, as: :context

  after_initialize :init_key
  before_destroy :have_active_topics?, prepend: true

  def init_key
    self.key ||= SecureRandom.hex
  end

  private
  def have_active_topics?
    unless topics.where(active: true).count == 0
      errors[:base] << 'Cannot delete Topic Group with active Topics'
      false
    end
  end

end
