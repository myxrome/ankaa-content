class Topic < ActiveRecord::Base
  has_many :categories, -> { order 'categories.order' }, inverse_of: :topic, dependent: :destroy
  has_many :values, -> { where('values.active = true') },
           through: :categories
  has_many :facts, as: :context
  after_initialize :init_key

  def init_key
    self.key ||= SecureRandom.hex
  end

end
