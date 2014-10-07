class Value < ActiveRecord::Base
  require 'concerns/raconcilable'
  include Reconcilable

  belongs_to :category, touch: true, inverse_of: :values
  has_many :descriptions, -> { order :order }, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :descriptions, reject_if: :all_blank, allow_destroy: true
  has_many :promos, -> { order :order }, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :promos, reject_if: :all_blank, allow_destroy: true
  has_many :facts, as: :context

  def thumb
    promos.first.image.url(:thumb) if promos
  end

  def reconcile(params)
    update(params.except(:descriptions_attributes, :promos_attributes).merge(active: (!self.url.nil? && !self.url.empty?)))
    reconcile_child(descriptions, params[:descriptions_attributes], nil)
    reconcile_child(promos, params[:promos_attributes], nil)
  end

end
