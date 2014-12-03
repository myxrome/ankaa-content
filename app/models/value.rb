class Value < ActiveRecord::Base
  include Reconcilable

  belongs_to :category, inverse_of: :values
  has_many :descriptions, -> { order :order }, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :descriptions, reject_if: :all_blank, allow_destroy: true
  has_many :promos, -> { order :order }, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :promos, reject_if: :all_blank, allow_destroy: true
  has_many :facts, as: :context

  def thumb
    if promos
      first = promos.first
      first.image.url(:thumb) if first
    end
  end

  def reconcile(params, callback_context)
    assign_attributes(params.except(:descriptions_attributes, :promos_attributes))
    assign_attributes(active: (!self.url.nil? && !self.url.empty?))
    self
  end

  def reconcile_associations(params, callback_context)
    reconcile_association(self.descriptions, params[:descriptions_attributes], callback_context)
    reconcile_association(self.promos, params[:promos_attributes].sort_by { |v| v[:order] }.first(7), callback_context)
  end

  def on_create(child, callback_context)
    category.on_update(self, callback_context)
  end

  def on_update(child, callback_context)
    category.on_update(self, callback_context)
  end

  def on_delete(child, callback_context)
    category.on_update(self, callback_context)
  end

end
