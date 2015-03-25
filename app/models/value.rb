class Value < ActiveRecord::Base
  include FileKey

  belongs_to :category, inverse_of: :values
  belongs_to :partner, inverse_of: :values
  has_many :descriptions, -> { order :order }, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :descriptions, reject_if: :all_blank, allow_destroy: true
  has_many :promos, -> { order :order }, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :promos, reject_if: :all_blank, allow_destroy: true
  has_many :facts, as: :context
  before_save :init_discount

  has_attached_file :thumb,
                    styles: {
                        x100: {geometry: '100x100', quality: 92, format: :jpg},
                        x200: {geometry: '200x200', quality: 92, format: :jpg},
                        x300: {geometry: '300x300', quality: 92, format: :jpg},
                        x400: {geometry: '400x400', quality: 92, format: :jpg},
                        x500: {geometry: '500x500', quality: 92, format: :jpg},
                        x600: {geometry: '600x600', quality: 92, format: :jpg},
                        x700: {geometry: '700x700', quality: 92, format: :jpg},
                        x800: {geometry: '800x800', quality: 92, format: :jpg},
                        x900: {geometry: '900x900', quality: 92, format: :jpg},
                    },
                    default_style: :x300,
                    url: '/content/v/:id/thumb/:style/:file_key.:extension'

  validates_attachment_content_type :thumb, :content_type => %w(image/jpeg image/jpg image/png)

  def init_discount
    self.discount ||= 100 - ((self.new_price * 100) / self.old_price)
  end

end
