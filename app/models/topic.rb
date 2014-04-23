class Topic < ActiveRecord::Base
  has_many :categories, -> { order 'categories.order' }, inverse_of: :topic, dependent: :destroy
  has_many :values, -> { where('values.active = true and values.end_date > ?', DateTime.now.to_date) },
           through: :categories
  after_initialize :init_key

  def init_key
    self.key ||= SecureRandom.hex
  end

end
