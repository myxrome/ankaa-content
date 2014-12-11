module FileKey
  extend ActiveSupport::Concern

  included do
    after_initialize :init_file_key
  end

  def init_file_key
    self.file_key ||= SecureRandom.hex[0..9]
  end

  Paperclip.interpolates :file_key do |attachment, style|
    attachment.instance.file_key
  end

end