class Category < ActiveRecord::Base
  include Orderable
  include Reconcilable

  scope :neighbors, -> (category) { where(topic_id: category.topic_id) }
  def neighbors
    Category.neighbors(self)
  end

  belongs_to :topic, inverse_of: :categories
  has_many :values, -> { order(:name) }, inverse_of: :category, dependent: :destroy
  has_many :facts, as: :context

  def reconcile(miner, params)
    reconcile_children(self.values.where(active: true), params, miner)
  end

  protected
  def on_create(child, callback_context)
    callback_context.on_new child
  end

  def on_update(child, callback_context)
    callback_context.on_update child
  end

  def on_delete(child, callback_context)
    callback_context.on_delete child
  end

  def on_error(e, callback_context)
    callback_context.on_error "#{e.backtrace.first}: #{e.message} (#{e.class})"
  end

  def delete(child)
    child.update_attribute(:active, false)
  end

end
