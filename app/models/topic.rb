class Topic < ActiveRecord::Base
  belongs_to :topic_group, inverse_of: :topics
  has_many :categories, -> { order(:order) }, inverse_of: :topic, dependent: :destroy
  has_many :facts, as: :context

end
