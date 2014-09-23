class Category < ActiveRecord::Base
  belongs_to :topic, touch: true, inverse_of: :categories
  has_many :values, -> { where active: true, order :name }, inverse_of: :category, dependent: :destroy
  has_many :facts, as: :context
  after_create :reorder

  def reorder
    update_attribute(:order, (Category.where('categories.topic_id = ?', self.topic_id).
        maximum(:order) || 0) + 1) unless self.order
  end

  def move_up
    upper = Category.where('categories.topic_id = ? AND categories.order < ?',
                           self.topic_id, self.order).order(order: :desc).limit(1).first
    switch_order(upper) if upper
  end

  def move_down
    lower = Category.where('categories.topic_id = ? AND categories.order > ?',
                           self.topic_id, self.order).order(order: :asc).limit(1).first
    switch_order(lower) if lower
  end

  private
  def switch_order(other)
    low = other.order
    other.update_attribute(:order, self.order)
    update_attribute(:order, low)
  end

end
