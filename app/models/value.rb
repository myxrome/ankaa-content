class Value < ActiveRecord::Base
  include Reconcilable

  belongs_to :category, inverse_of: :values
  has_many :descriptions, -> { order :order }, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :descriptions, reject_if: :all_blank, allow_destroy: true
  has_many :promos, -> { order :order }, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :promos, reject_if: :all_blank, allow_destroy: true
  has_many :facts, as: :context

  def thumb
    promos.first.image.url(:thumb) if promos
  end

  def reconcile(params)
    assign_attributes(params.except(:descriptions_attributes, :promos_attributes))
    assign_attributes(active: (!self.url.nil? && !self.url.empty?))
    reconcile_children(self.descriptions, params[:descriptions_attributes], nil)
    reconcile_children(self.promos, params[:promos_attributes], nil)
    save! if changed?
    self
  end

end
