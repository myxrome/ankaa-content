class Promo < ActiveRecord::Base
  include FileKey

  belongs_to :value, inverse_of: :promos

  Paperclip.interpolates :value_id do |attachment, style|
    attachment.instance.value_id
  end

  has_attached_file :image,
                    styles: {
                        x100: {geometry: '200x200', quality: 92, format: :jpg},
                        x200: {geometry: '400x400', quality: 92, format: :jpg},
                        x300: {geometry: '600x600', quality: 92, format: :jpg},
                        x400: {geometry: '800x800', quality: 92, format: :jpg},
                        x500: {geometry: '1000x1000', quality: 92, format: :jpg},
                        x600: {geometry: '1200x1200', quality: 92, format: :jpg},
                        x700: {geometry: '1400x1400', quality: 92, format: :jpg},
                        x800: {geometry: '1600x1600', quality: 92, format: :jpg},
                        x900: {geometry: '1800x1800', quality: 92, format: :jpg},
                    },
                    default_style: :x300,
                    url: '/content/v/:value_id/promo/:style/:id:file_key.:extension'

  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)

end
