class Topic < ActiveRecord::Base
  require 'concerns/orderable'
  include Orderable

  scope :neighbors, -> (topic) { all }

  def neighbors
    Topic.neighbors(self)
  end

  has_many :categories, -> { where(active: true).order(:order) }, inverse_of: :topic, dependent: :destroy
  has_many :facts, as: :context
  after_initialize :init_key

  def init_key
    self.key ||= SecureRandom.hex
  end

end
