module ActiveModel
  extend ActiveSupport::Concern

  def destroy
    update_attribute :active, false
  end

  def destroy_from_db
    self.class.superclass.instance_method(:destroy).bind(self).call
  end

end