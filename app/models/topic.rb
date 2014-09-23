class Topic < ActiveRecord::Base
  has_many :categories, -> { where active: true, order :order }, inverse_of: :topic, dependent: :destroy
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
    switch_order(upper) if upper
  end

  def move_down
    lower = Topic.where('topics.order > ?', self.order).order(order: :asc).limit(1).first
    switch_order(lower) if lower
  end

  private
  def switch_order(other)
    low = other.order
    other.update_attribute(:order, self.order)
    update_attribute(:order, low)
  end

end
