class Value < ActiveRecord::Base
  require 'concerns/active_model'
  include ActiveModel

  belongs_to :category, touch: true, inverse_of: :values
  has_many :descriptions, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :descriptions, reject_if: :all_blank, allow_destroy: true
  has_many :promos, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :promos, reject_if: :all_blank, allow_destroy: true
  has_many :facts, as: :context

  def thumb
    promos.first.image.url(:thumb) if promos
  end

end
