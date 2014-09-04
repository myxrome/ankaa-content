module ActiveModel
  extend ActiveSupport::Concern

  included do
    before_destroy :deactivate
  end

  def deactivate
    self.active = false
    save!
    false
  end

end