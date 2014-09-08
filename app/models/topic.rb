class Topic < ActiveRecord::Base
  include ActiveModel
  has_many :categories, -> { where active: true }, inverse_of: :topic, dependent: :destroy
  has_many :values, through: :categories
  has_many :facts, as: :context
  after_initialize :init_key

  def init_key
    self.key ||= SecureRandom.hex
  end

end
