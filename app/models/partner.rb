class Partner < ActiveRecord::Base
  include FileKey

  has_many :values, inverse_of: :partner
  has_many :facts, as: :context

  has_attached_file :logo,
                    styles: {
                        x100: {geometry: '50x50', quality: 92, format: :jpg},
                        x200: {geometry: '100x100', quality: 92, format: :jpg},
                        x300: {geometry: '150x150', quality: 92, format: :jpg},
                        x400: {geometry: '200x200', quality: 92, format: :jpg},
                        x500: {geometry: '250x250', quality: 92, format: :jpg},
                        x600: {geometry: '300x300', quality: 92, format: :jpg}
                    },
                    default_style: :x300,
                    url: '/content/p/:id/logo/:style/:file_key.:extension'
  validates_attachment_content_type :logo, :content_type => %w(image/jpeg image/jpg image/png)

end
