class Value < ActiveRecord::Base
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

end
