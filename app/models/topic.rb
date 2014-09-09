class Topic < ActiveRecord::Base
  require 'concerns/active_model'
  include ActiveModel
  has_many :categories, -> { where active: true }, inverse_of: :topic, dependent: :destroy
  has_many :values, through: :categories
  has_many :facts, as: :context
  after_initialize :init_key
  after_create :reorder

  def init_key
    self.key ||= SecureRandom.hex
  end

  def reorder
    update_attribute(:order, (Topic.maximum(:order) || 0) + 1) unless self.order
  end

  def move_up
    upper = Topic.where('topics.order < ?', self.order).order(order: :desc).limit(1).first
    if upper
      low = upper.order
      upper.update_attribute(:order, self.order)
      update_attribute(:order, low)
    end
  end

  def move_down
    lower = Topic.where('topics.order > ?', self.order).order(order: :asc).limit(1).first
    if lower
      up = lower.order
      lower.update_attribute(:order, self.order)
      update_attribute(:order, up)
    end
  end

end
