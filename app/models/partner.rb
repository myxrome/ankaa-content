class Partner < ActiveRecord::Base
  include FileKey

  has_attached_file :logo, styles: {default: {quality: 92, format: :jpg}},
                    default_style: :default, url: '/content/l/:id/:file_key_:style.:extension'
  validates_attachment_content_type :logo, :content_type => %w(image/jpeg image/jpg image/png)
  has_many :facts, as: :context

end
