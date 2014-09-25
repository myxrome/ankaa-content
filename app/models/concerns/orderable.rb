module Orderable
  extend ActiveSupport::Concern
  included do
    after_create :reorder
  end

  def reorder
    update_attribute(:order, (neighbors.maximum(:order) || 0) + 1) unless self.order
  end

  def move_up
    upper = neighbors.where("#{self.class.table_name}.order < ?", self.order).
        order(order: :desc).limit(1).first
    switch_order(upper) if upper
  end

  def move_down
    lower = neighbors.where("#{self.class.table_name}.order > ?", self.order).
        order(order: :desc).limit(1).first
    switch_order(lower) if lower
  end

  private
  def switch_order(other)
    low = other.order
    other.update_attribute(:order, self.order)
    update_attribute(:order, low)
  end

end