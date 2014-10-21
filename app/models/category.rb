class Category < ActiveRecord::Base
  include Orderable
  include Reconcilable

  scope :neighbors, -> (category) { where(topic_id: category.topic_id) }
  def neighbors
    Category.neighbors(self)
  end

  belongs_to :topic, inverse_of: :categories
  has_many :values, -> { where(active: true).order(:name) }, inverse_of: :category, dependent: :destroy
  has_many :facts, as: :context

  def reconcile(params)
    reconcile_children(self.values, params, {new: [], update: [], delete: []})
  end

  protected
  def on_create(child, callback_context)
    callback_context[:new] << child.source
  end

  def on_update(child, callback_context)
    callback_context[:update] << child.source
  end

  def on_delete(child, callback_context)
    callback_context[:delete] << child.source
  end

  def delete(child)
    child.update_attribute(:active, false)
  end

end
