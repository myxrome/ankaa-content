class Promo < ActiveRecord::Base
  include Reconcilable
  include FileKey

  belongs_to :value, touch: true, inverse_of: :promos

  Paperclip.interpolates :value_id do |attachment, style|
    attachment.instance.value_id
  end

  has_attached_file :image, styles: {
      xhdpi: {geometry: '100%', quality: 92, format: :jpg },
      hdpi: {geometry: '75%', quality: 92, format: :jpg },
      mdpi: {geometry: '50%', quality: 92, format: :jpg },
      ldpi: {geometry: '37%', quality: 92, format: :jpg },
      thumb: {geometry: '100x100', quality: 92, format: :jpg }
  }, default_style: :xhdpi, url: '/content/p/:value_id/:id/:file_key:style.:extension'

  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)

  def reconcile(params, callback_context)
    assign_attributes(image.exists? ? params.except(:image) : params)
    self
  end

end
