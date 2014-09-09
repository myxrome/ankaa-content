class Category < ActiveRecord::Base
  require 'concerns/active_model'
  include ActiveModel

  belongs_to :topic, touch: true, inverse_of: :categories
  has_many :values, -> { where active: true }, inverse_of: :category, dependent: :destroy
  has_many :facts, as: :context
  after_create :reorder

  def reorder
    update_attribute(:order, (Category.where('categories.topic_id = ?', self.topic_id).
        maximum(:order) || 0) + 1) unless self.order
  end

  def move_up
    upper = Category.where('categories.topic_id = ? AND categories.order < ?',
                           self.topic_id, self.order).order(order: :desc).limit(1).first
    if upper
      low = upper.order
      upper.update_attribute(:order, self.order)
      update_attribute(:order, low)
    end
  end

  def move_down
    lower = Category.where('categories.topic_id = ? AND categories.order > ?',
                           self.topic_id, self.order).order(order: :asc).limit(1).first
    if lower
      up = lower.order
      lower.update_attribute(:order, self.order)
      update_attribute(:order, up)
    end
  end

end
