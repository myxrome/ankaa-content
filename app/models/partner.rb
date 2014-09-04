class Partner < ActiveRecord::Base
  include ActiveModel

  has_attached_file :logo, url: '/content/l/:id/:hash.:extension', hash_secret: '933QPmmE2uEvGULxSw4jvWEh'
  validates_attachment_content_type :logo, :content_type => %w(image/jpeg image/jpg image/png)
  has_many :facts, as: :context

end
